import 'package:flutter/material.dart';

class BaseContainer extends StatelessWidget {
  final Color color;
  final Widget child;

  BaseContainer({this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: child,
    );
  }
}
