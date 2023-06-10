import 'package:flutter/material.dart';
import 'dart:math' as math;

class JumpAnimation extends StatefulWidget {
  final Widget child;
  final double frequency;

  JumpAnimation({this.child, this.frequency});

  @override
  JumpAnimationState createState() => JumpAnimationState();
}

class JumpAnimationState extends State<JumpAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController motionController;
  Animation<double> _animation;
  Tween<double> _tween;
  math.Random _random = math.Random();

  double getRandomAngle() {
    return math.pi * 2 / 25 * _random.nextInt(25);
  }

  void initState() {
    super.initState();

    motionController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _tween = Tween(begin: 1, end: 6);
    _animation = _tween.animate(motionController);

    motionController.forward();

    motionController.addStatusListener((status) {
      setState(() {
        if (status == AnimationStatus.completed) {
          motionController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          motionController.forward();
        }
      });
    });
  }

  @override
  void dispose() {
    motionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: motionController,
      builder: (BuildContext context, Widget child) {
        return  Column(
          children: [
            SizedBox(
              height: (widget.frequency ?? 2) * _animation.value,
            ),
            child
          ],
        );
      },
      child: widget.child
    );
  }
}
