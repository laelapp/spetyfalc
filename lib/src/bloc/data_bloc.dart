// ignore_for_file: deprecated_member_use
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spetyfalc/src/database/database_helper.dart';
import 'package:spetyfalc/src/model/data_model.dart';
import 'package:spetyfalc/src/model/image_model.dart';

class DataBloc {
  final _fetch = PublishSubject<List<DataModel>>();
  final _fetch1 = PublishSubject<List<Category>>();
  final DatabaseHelper _helper = DatabaseHelper();

  Stream<List<DataModel>> get data => _fetch.stream;

  Stream<List<Category>> get data1 => _fetch1.stream;
  late DatabaseReference _db;

  getData(String search) async {
    List<DataModel> data = [];
    _db = FirebaseDatabase.instance.reference();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _db.child('info').onValue.listen(
      (event) async {
        data = <DataModel>[];
        List<Category> catList = [];
        List<Category> likeList = [];

        for (var fData in event.snapshot.children) {
          bool block = prefs.getBool(
                  "Block${fData.child("category").child("subTitle").value.toString()}${fData.child("category").child("title").value.toString()}") ??
              false;
          bool like = prefs.getBool(
                  "Like${fData.child("category").child("name").value.toString()}${fData.child("category").child("title").value.toString()}") ??
              false;

          List<String> image = [];

          for (var iData in fData.child("category").child("image").children) {
            image.add(iData.value.toString());
          }

          Category category = Category(
            id: 0,
            name: fData.child("category").child("name").value.toString(),
            title: fData.child("category").child("title").value.toString(),
            subTitle:
                fData.child("category").child("subTitle").value.toString(),
            description:
                fData.child("category").child("description").value.toString(),
            image: image,
          );
          if (!block) {
            catList.add(category);
            if (like) {
              likeList.add(category);
            }
          }
        }

        for (int i = 0; i < catList.length; i++) {
          List<Category> fd = [];

          String namee = "";
          if (catList[i].name != "") {
            namee = catList[i].name;
            fd.add(catList[i]);
          }
          for (int j = i + 1; j < catList.length; j++) {
            if (catList[i].name != "" &&
                catList[j].name.toLowerCase() ==
                    catList[i].name.toLowerCase()) {
              namee = catList[j].name;
              fd.add(catList[j]);
              catList[j].name = "";
            }
          }
          if (fd.isNotEmpty) {
            DataModel mode1 = DataModel(
              id: "",
              name: namee,
              data: fd,
            );
            data.add(mode1);
            fd = [];
          }
        }
        List<Category> cat = await _helper.getData();
        List<Category> cat1 = [];

        for (int i = 0; i < cat.length; i++) {
          bool block =
              prefs.getBool("Block${cat[i].name}${cat[i].title}") ?? false;
          bool like =
              prefs.getBool("Like${cat[i].name}${cat[i].title}") ?? false;
          if (!block) {
            cat1.add(cat[i]);
            if (like) {
              likeList.add(cat[i]);
            }
          }
        }
        for (int i = 0; i < cat1.length; i++) {
          List<ImageModel> img = await _helper
              .getImage(cat1[i].title.trim() + cat1[i].subTitle.trim());
          for (int j = 0; j < img.length; j++) {
            if (cat1[i].title + cat1[i].subTitle == img[j].type) {
              cat1[i].image.add(String.fromCharCodes(img[j].image));
            }
          }
        }
        DataModel mode1 = DataModel(
          id: "",
          name: "My Guides",
          data: cat1,
        );
        if (cat1.isNotEmpty) {
          data.add(mode1);
        }
        if (likeList.isNotEmpty) {
          // for (int i = 0; i < likeList.length; i++) {
          //   likeList[i].name = "Favourite";
          // }
          DataModel mode1 = DataModel(
            id: "",
            name: "Favourite",
            data: likeList,
          );
          data.add(mode1);
        }
        _fetch.sink.add(data);
      },
    );
  }

  getSearch(String search) async {
    List<Category> data = [];
    _db = FirebaseDatabase.instance.reference();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _db.child('info').onValue.listen(
      (event) async {
        data = <Category>[];
        List<Category> catList = [];

        for (var element in event.snapshot.children) {
          for (var fData in element.children) {
            String n = fData.child("category").child("name").value.toString();
            String t = fData.child("category").child("title").value.toString();
            String s =
                fData.child("category").child("subTitle").value.toString();
            String d =
                fData.child("category").child("description").value.toString();
            if (n.toLowerCase().contains(search.toLowerCase()) ||
                t.toLowerCase().contains(search.toLowerCase()) ||
                s.toLowerCase().contains(search.toLowerCase()) ||
                d.toLowerCase().contains(search.toLowerCase())) {
              bool block = prefs.getBool(
                      "Block${fData.child("category").child("name").value.toString()}${fData.child("category").child("title").value.toString()}") ??
                  false;

              List<String> image = [];

              for (var iData
                  in fData.child("category").child("image").children) {
                image.add(iData.value.toString());
              }

              Category category = Category(
                id: 0,
                name: fData.child("category").child("name").value.toString(),
                title: fData.child("category").child("title").value.toString(),
                subTitle:
                    fData.child("category").child("subTitle").value.toString(),
                description: fData
                    .child("category")
                    .child("description")
                    .value
                    .toString(),
                image: image,
              );
              if (!block) {
                catList.add(category);
              }
            }
          }
        }

        List<Category> cat = await _helper.getData();
        for (int i = 0; i < cat.length; i++) {
          bool block =
              prefs.getBool("Block${cat[i].name}${cat[i].title}") ?? false;
          String n = cat[i].name;
          String t = cat[i].title;
          String s = cat[i].subTitle;
          String d = cat[i].description;
          if (n.toLowerCase().contains(search.toLowerCase()) ||
              t.toLowerCase().contains(search.toLowerCase()) ||
              s.toLowerCase().contains(search.toLowerCase()) ||
              d.toLowerCase().contains(search.toLowerCase())) {
            if (!block) {
              catList.add(cat[i]);
            }
          }
        }

        if (catList.isNotEmpty) {
          data.addAll(catList);
        }
        _fetch1.sink.add(data);
      },
    );
  }
}

final dataBloc = DataBloc();
