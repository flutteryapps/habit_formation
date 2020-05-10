import 'package:flutter/material.dart';

const LEFT_SECTION_WIDTH = 160.0;

class SwipeAnimation extends StatefulWidget {
  final Widget child;

  SwipeAnimation({this.child});

  @override
  _SwipeAnimationState createState() => _SwipeAnimationState();
}

class _SwipeAnimationState extends State<SwipeAnimation> {
  double initialX = 0;
  double dx = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onHorizontalDragStart: (details) {
        initialX = details.globalPosition.dx;
      },
      onHorizontalDragUpdate: (details) {
        double tempX = details.globalPosition.dx;
//        if (tempX >= LEFT_SECTION_WIDTH) {
//          translateX(LEFT_SECTION_WIDTH);
//        } else {
//          translateX(tempX);
//        }



        // translateX(tempX);

        if (initialX > tempX) {
          print("rtl");
          translateX(tempX- initialX);
          print(tempX- initialX);
        } else {
          print("ltr");
          print(tempX);
          translateX(tempX);
        }

//        print(
//            "${details.localPosition.dx}, ${details.globalPosition.dx} ${details.delta.dx}");
//        switch (Directionality.of(context)) {
//          case TextDirection.rtl:
//
//            break;
//          case TextDirection.ltr:
//            print("ltr");
//            break;
//        }
      },
      onHorizontalDragEnd: (details) {
//        if (dx >= LEFT_SECTION_WIDTH) {
//          resetPosition(2);
//        } else if (dx >= LEFT_SECTION_WIDTH / 2) {
//          translateX(LEFT_SECTION_WIDTH);
//          resetPosition(2);
//        } else {
//          translateX(0);
//        }
      },
      child: Transform.translate(
        offset: Offset(dx, 0),
        child: widget.child,
      ),
    );
  }

  void resetPosition(int seconds) {
    Future.delayed(Duration(seconds: seconds), () => translateX(0));
  }

  void translateX(double dx) {
    setState(() {
      this.dx = dx;
    });
  }
}
// 167.66665649414062, 167.66665649414062 -0.333343505859375
