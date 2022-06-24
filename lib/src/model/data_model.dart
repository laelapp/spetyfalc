class DataModel {
  String id;
  String name;
  List<Category> data;

  DataModel({
    required this.id,
    required this.name,
    required this.data,
  });
}

class Category {
  int id;
  String name;
  String title;
  String subTitle;
  String description;
  List<String> image;

  Category({
    required this.id,
    required this.name,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['title'] = title;
    data['subTitle'] = subTitle;
    data['description'] = description;

    return data;
  }
}
