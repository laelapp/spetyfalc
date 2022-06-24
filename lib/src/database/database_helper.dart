// ignore_for_file: depend_on_referenced_packages

import 'package:path/path.dart';
import 'package:spetyfalc/src/model/data_model.dart';
import 'package:spetyfalc/src/model/image_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper.internal();

  final String imageTableName = 'imageTableName';
  final String imageColumnId = 'id';
  final String imageColumnType = 'type';
  final String imageColumnImage = 'image';

  final String dataTableName = 'dataTableName';
  final String dataColumnId = 'id';
  final String dataColumnName = 'name';
  final String dataColumnTitle = 'title';
  final String dataColumnSubTitle = 'subTitle';
  final String dataColumnDescription = 'description';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();

    return _db!;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'userTableData.db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $imageTableName('
      '$imageColumnId INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$imageColumnType TEXT, '
      '$imageColumnImage BLOB)',
    );

    await db.execute(
      'CREATE TABLE $dataTableName('
      '$dataColumnId INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$dataColumnName TEXT, '
      '$dataColumnTitle TEXT, '
      '$dataColumnSubTitle TEXT, '
      '$dataColumnDescription TEXT)',
    );
  }

  Future<int> saveImage(List<ImageModel> image) async {
    var dbClient = await db;
    for (int i = 0; i < image.length; i++) {
      await dbClient.insert(
        imageTableName,
        image[i].toJson(),
      );
    }
    return 1;
  }

  Future<int> saveData(Category data) async {
    var dbClient = await db;
    await dbClient.insert(
      dataTableName,
      data.toJson(),
    );
    return 1;
  }

  Future<List<Category>> getData() async {
    var dbClient = await db;
    List<Category> data = [];
    List<Map> list = await dbClient.rawQuery('SELECT * FROM $dataTableName');
    for (int i = 0; i < list.length; i++) {
      data.add(
        Category(
          id: list[i][dataColumnId],
          name: list[i][dataColumnName],
          title: list[i][dataColumnTitle],
          subTitle: list[i][dataColumnSubTitle],
          description: list[i][dataColumnDescription],
          image: [],
        ),
      );
    }
    return data;
  }

  Future<List<ImageModel>> getImage(String type) async {
    var dbClient = await db;
    List<ImageModel> data = [];
    List<Map> list = await dbClient.rawQuery('SELECT * FROM $imageTableName');

    for (int i = 0; i < list.length; i++) {
      data.add(
        ImageModel(
          id: list[i][imageColumnId],
          type: list[i][imageColumnType],
          image: list[i][imageColumnImage],
        ),
      );
    }
    return data;
  }
}
