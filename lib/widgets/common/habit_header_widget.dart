import 'package:flutter/material.dart';

class HabitHeaderWidget extends StatelessWidget {

  final String title;
  final String routineInfo;
  final IconData iconData;

  HabitHeaderWidget({
    @required this.title,
    @required this.routineInfo,
    @required this.iconData
});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              routineInfo,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
              ),
            )
          ],
        ),
        Icon(iconData)
      ],
    );
  }
}
