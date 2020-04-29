import 'dart:convert';

import 'package:iyawo/models/dashboard_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class DashboardDBService {
  static final DashboardDBService _dbHelper = DashboardDBService._internal();

  DashboardDBService._internal();

  factory DashboardDBService() {
    return _dbHelper;
  }

  String tbl = 'Account';
  String colId = 'id';
  String colData = "data";
  String colLastUpdated = 'lastUpdated';

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDB();
    }
    return _db;
  }

  Future<Database> initializeDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "/iyawo.db";
    var todosDB = await openDatabase(path, version: 1, onCreate: _createDB);
    return todosDB;
  }

  void _createDB(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tbl ($colId INTEGER PRIMARY KEY, $colData TEXT, $colLastUpdated TEXT)");
  }

  Future<int> insert(Dashboard data) async {
    Database db = await this.db;
    int count = await getCount();
    if (count > 0) {
      deleteAll();
    }
    var result = await db.insert(tbl, {
      '$colData': jsonEncode(data.toJson()),
      '$colLastUpdated': new DateTime.now().toString()
    });
    return result;
  }

  Future<int> update(Dashboard data) async {
    Database db = await this.db;
    var result = await db.update(
        tbl,
        {
          '$colData': jsonEncode(data.toJson()),
          '$colLastUpdated': new DateTime.now().toString()
        },
        where: "$colId = ?",
        whereArgs: [1]);
    return result;
  }

  Future<List> getAll() async {
    Database db = await this.db;
    var results = await db.rawQuery("SELECT * FROM $tbl ORDER BY $colId ASC");
    return results;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result =
        Sqflite.firstIntValue(await db.rawQuery("SELECT count(*) FROM $tbl"));
    return result;
  }

  Future<int> deleteAll() async {
    Database db = await this.db;
    var result = await db.rawDelete("DELETE FROM $tbl");
    return result;
  }
}
