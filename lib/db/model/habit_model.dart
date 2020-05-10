import 'package:flutter/material.dart';

class HabitModel {
  static const TABLE_NAME = 'habit_model';
  static const COLUMN_ID = 'id';
  static const COLUMN_NAME = 'name';
  static const COLUMN_STARTING_DATE = 'starting_date';
  static const COLUMN_REPETITION = 'repetition';
  static const COLUMN_DESCRIPTION = 'description';

  int id;
  String name;
  int startingDate;
  String repetition;
  String description;

  HabitModel(
      {this.id,
      @required this.name,
      @required this.startingDate,
      @required this.repetition,
      this.description});

  Map<String, dynamic> getRow() {
    return {
      COLUMN_ID: id,
      COLUMN_NAME: name,
      COLUMN_STARTING_DATE: startingDate,
      COLUMN_REPETITION: repetition,
      COLUMN_DESCRIPTION: description,
    };
  }

  static String getCreateTableQuery() {
    return '''CREATE TABLE $TABLE_NAME (
            $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
            $COLUMN_NAME TEXT NOT NULL,
            $COLUMN_STARTING_DATE INTEGER NOT NULL,
            $COLUMN_REPETITION TEXT NOT NULL,
            $COLUMN_DESCRIPTION TEXT
          )
          ''';
  }

  static HabitModel getHabitModelFromRow(Map<String, dynamic> row) {
    int id = row[COLUMN_ID];
    String name = row[COLUMN_NAME];
    int startingDate = row[COLUMN_STARTING_DATE];
    String repetition = row[COLUMN_REPETITION];
    String description =
        row.containsKey(COLUMN_DESCRIPTION) ? row[COLUMN_DESCRIPTION] : null;

    return HabitModel(id: id,
        name: name,
        startingDate: startingDate,
        repetition: repetition,
        description: description);
  }
}
