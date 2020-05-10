import 'package:flutter/cupertino.dart';
import 'package:habitformation/constants/constants.dart';

class HabitViewModel {
  int id;
  String name;
  int startingDate;
  String repetition;
  List<TrackingViewModel> trackingModels = [];

  HabitViewModel({
    @required this.id,
    @required this.name,
    @required this.startingDate,
    @required this.repetition,
    @required this.trackingModels,
  });
}

class TrackingViewModel {
  int id;
  int habitId;
  int dateTime;
  String dayName;
  bool isEnabled;
  bool isToday;
  HabitDayState habitDayState;

  TrackingViewModel({
    @required this.id,
    @required this.habitId,
    @required this.dateTime,
    @required this.dayName,
    @required this.isEnabled,
    @required this.isToday,
    @required this.habitDayState,
  });
}
