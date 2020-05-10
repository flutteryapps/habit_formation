import 'package:flutter/material.dart';
import 'package:habitformation/common/habit_view_model.dart';
import 'package:habitformation/datasource/data_source.dart';
import 'package:provider/provider.dart';

import 'day_widget.dart';

class WeekWidget extends StatelessWidget {
  final int index;

  WeekWidget(this.index);

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitNotifier>(builder: (context, habitsNotifier, child) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: getDays(habitsNotifier.habits[index].trackingModels),
      );
    });
  }

  List<Widget> getDays(List<TrackingViewModel> trackingModels) {
    List<Widget> days = [];
    for (TrackingViewModel trackingViewModel in trackingModels) {
      days.add(DayWidget(trackingViewModel));
    }

    return days;
  }
}
