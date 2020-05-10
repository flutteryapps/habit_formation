import 'dart:io';

import 'package:habitformation/db/model/habit_model.dart';
import 'package:habitformation/db/model/tracking_model.dart';
import 'package:habitformation/utils/core_utils.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(HabitModel.getCreateTableQuery());
    await db.execute(TrackingModel.getCreateTableQuery());
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insertHabitModel(HabitModel habitModel) async {
    Database db = await instance.database;
    Map<String, dynamic> row = habitModel.getRow();
    return await db.insert(HabitModel.TABLE_NAME, row);
  }

  Future<int> insertTrackingModel(TrackingModel trackingModel) async {
    Database db = await instance.database;
    Map<String, dynamic> row = trackingModel.getRow();
    return await db.insert(TrackingModel.TABLE_NAME, row);
  }

  Future<int> deleteTrackingModel(int trackingId) async {
    Database db = await instance.database;
    return await db.delete(TrackingModel.TABLE_NAME,
        where: '${TrackingModel.COLUMN_ID} = ?', whereArgs: [trackingId]);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<HabitModel>> queryAllHabits() async {
    Database db = await instance.database;

    final allHabits = await db.query(HabitModel.TABLE_NAME);
    return allHabits.map((e) => HabitModel.getHabitModelFromRow(e)).toList();
  }

  Future<HabitModel> getHabitById(int id) async {
    Database db = await instance.database;
    return await db
        .rawQuery('SELECT * FROM ${HabitModel.TABLE_NAME} WHERE id=$id')
        .then((value) =>
            value.map((e) => HabitModel.getHabitModelFromRow(e)).first);
  }

  Future<List<TrackingModel>> queryAllTracking(int habitId) async {
    Database db = await instance.database;
    return await db
        .rawQuery(
            'SELECT * FROM ${TrackingModel.TABLE_NAME} WHERE ${TrackingModel.COLUMN_HABIT_ID}=$habitId')
        .then((value) => value
            .map((e) => TrackingModel.getTrackingModelFromRow(e))
            .toList());
  }

  Future<List<TrackingModel>> queryAllTrackingDetails() async {
    Database db = await instance.database;
    final list = await db.rawQuery(
        'SELECT * FROM ${TrackingModel.TABLE_NAME} WHERE ${TrackingModel.COLUMN_CHECKED_DATE} >= ${CoreUtils.getWeek()[0].dateTime.millisecondsSinceEpoch}');
    return list.map((e) => TrackingModel.getTrackingModelFromRow(e)).toList();

    //.then((value) => value.map((e) => TrackingModel.getTrackingModelFromRow(e)).toList());
  }

//  // All of the methods (insert, query, update, delete) can also be done using
//  // raw SQL commands. This method uses a raw query to give the row count.
//  Future<int> queryRowCount() async {
//    Database db = await instance.database;
//    return Sqflite.firstIntValue(
//        await db.rawQuery('SELECT COUNT(*) FROM $table'));
//  }
//
//  // We are assuming here that the id column in the map is set. The other
//  // column values will be used to update the row.
//  Future<int> update(Map<String, dynamic> row) async {
//    Database db = await instance.database;
//    int id = row[columnId];
//    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
//  }
//
//  // Deletes the row specified by the id. The number of affected rows is
//  // returned. This should be 1 as long as the row exists.
//  Future<int> delete(int id) async {
//    Database db = await instance.database;
//    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
//  }
}
