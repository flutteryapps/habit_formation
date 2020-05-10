import 'package:flutter/material.dart';

class TrackingModel {
  static const TABLE_NAME = 'tracking_model';
  static const COLUMN_ID = 'id';
  static const COLUMN_HABIT_ID = 'habit_id';
  static const COLUMN_CHECKED_DATE = 'checked_date';

  int id;
  int habitId;
  int checkedDate;

  TrackingModel({this.id, @required this.habitId, @required this.checkedDate});

  Map<String, dynamic> getRow() {
    return {
      COLUMN_ID: id,
      COLUMN_HABIT_ID: habitId,
      COLUMN_CHECKED_DATE: checkedDate,
    };
  }

  static String getCreateTableQuery() {
    return '''CREATE TABLE $TABLE_NAME (
            $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
            $COLUMN_HABIT_ID INTEGER NOT NULL,
            $COLUMN_CHECKED_DATE INTEGER NOT NULL
          )
          ''';
  }

  static TrackingModel getTrackingModelFromRow(Map<String, dynamic> row) {
    int id = row[COLUMN_ID];
    int habitId = row[COLUMN_HABIT_ID];
    int checkedDate = row[COLUMN_CHECKED_DATE];

    return TrackingModel(id: id, habitId: habitId, checkedDate: checkedDate);
  }
}
