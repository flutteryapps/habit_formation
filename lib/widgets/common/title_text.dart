import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color color;

  TitleText(this.title, {this.fontSize, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: fontSize ?? 36, fontWeight: FontWeight.bold, color: color),
    );
  }
}
