import 'package:flutter/material.dart';

const LEFT_SECTION_WIDTH = 60.0;

class SwipeAnimation extends StatefulWidget {
  final Widget child;

  SwipeAnimation({this.child});

  @override
  _SwipeAnimationState createState() => _SwipeAnimationState();
}

class _SwipeAnimationState extends State<SwipeAnimation>
    with SingleTickerProviderStateMixin {
  double initialX = 0;
  double dx = 0;
  double lastX = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) {
        initialX = details.globalPosition.dx;
      },
      onHorizontalDragUpdate: (details) {
        lastX = details.globalPosition.dx;
        dx = (lastX - initialX);
        if (dx >= 0 && dx < LEFT_SECTION_WIDTH) {
          translateX(dx);
        }
      },
      onHorizontalDragEnd: (details) {
        if (dx > LEFT_SECTION_WIDTH / 3) {
          translateX(LEFT_SECTION_WIDTH);
          resetPosition(2000);
        } else {
          resetPosition(200);
        }
      },
      child: Transform.translate(
        offset: Offset(dx, 0),
        child: widget.child,
      ),
    );
  }

  void resetPosition(int milliseconds) {
    Future.delayed(Duration(milliseconds: milliseconds), () {
      setState(() {
        this.dx = 0;
        lastX = 0;
      });
    });
  }

  void translateX(double dx) {
    if (dx < 0) return;
    setState(() {
      this.dx = dx;
    });
  }
}
