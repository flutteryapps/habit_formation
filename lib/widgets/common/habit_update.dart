import 'package:flutter/material.dart';

class HabitUpdate extends StatelessWidget {
  final Function() onEdit;
  final Function() onDelete;

  HabitUpdate({this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: onEdit,
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 24,
          child: Divider(
            color: Colors.white,
            thickness: 1,
          ),
        ),
        GestureDetector(
          onTap: onDelete,
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
