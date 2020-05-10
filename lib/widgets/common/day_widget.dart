import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitformation/common/habit_view_model.dart';
import 'package:habitformation/constants/constants.dart';
import 'package:habitformation/datasource/data_source.dart';
import 'package:provider/provider.dart';

class DayWidget extends StatelessWidget {
  final TrackingViewModel trackingViewModel;

  DayWidget(this.trackingViewModel);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (trackingViewModel.isEnabled) {
          Provider.of<HabitNotifier>(context, listen: false)
              .markDone(trackingViewModel);
        }
      },
      child: Container(
        height: 80,
        child: Column(
          children: <Widget>[
            Text(
              trackingViewModel.dayName,
              style: TextStyle(
                fontSize: 12,
                fontWeight: trackingViewModel.isToday
                    ? FontWeight.w900
                    : FontWeight.normal,
              ),
            ),
            SizedBox(
              height: trackingViewModel.isToday ? 16 : 20,
            ),
            getWidgetIfHabitIsDone()
          ],
        ),
      ),
    );
  }

  Widget getWidgetIfHabitIsDone() {
    Color color;
    IconData iconData = Icons.done;

    switch (trackingViewModel.habitDayState) {
      case HabitDayState.NOT_APPLICABLE:
        color = Colors.black26;
        break;
      case HabitDayState.DONE:
        color = Colors.white;
        break;
      case HabitDayState.NOT_DONE:
        color = Colors.white;
        iconData = Icons.clear;
        break;
      case HabitDayState.PENDING:
        color = Colors.black;
        break;
    }

    return Container(
      height: trackingViewModel.isToday ? 40 : 32,
      width: trackingViewModel.isToday ? 40 : 32,
      decoration: getDecoration(),
      child: Center(
        child: Icon(
          iconData,
          color: color,
        ),
      ),
    );
  }

  BoxDecoration getDecoration() {
    switch (trackingViewModel.habitDayState) {
      case HabitDayState.NOT_APPLICABLE:
        return BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: Colors.black26,
          ),
        );
        break;
      case HabitDayState.DONE:
        return BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
        );
        break;
      case HabitDayState.NOT_DONE:
        return BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red.shade300,
        );
        break;
      case HabitDayState.PENDING:
        return BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: Colors.black, style: BorderStyle.solid),
        );
        break;
    }
  }
}
