import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeTransAnimation extends StatelessWidget {
  final Widget child;
  final int delayInMillisecond;

  final AxisDirection direction;

  final double translateYDistance;

  FadeTransAnimation(
      {@required this.delayInMillisecond,
      @required this.child,
      this.direction = AxisDirection.up,
      this.translateYDistance = 30});

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity")
          .add(const Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(
          const Duration(milliseconds: 500),
          direction == AxisDirection.up
              ? Tween(begin: -translateYDistance, end: 0.0)
              : (direction == AxisDirection.down
                  ? Tween(begin: translateYDistance, end: 0.0)
                  : (direction == AxisDirection.right
                      ? Tween(begin: translateYDistance, end: 0.0)
                      : Tween(begin: -translateYDistance, end: 0.0))),
          curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: delayInMillisecond),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: direction == AxisDirection.right ||
                    direction == AxisDirection.left
                ? Offset(animation["translateY"], 0)
                : Offset(0, animation["translateY"]),
            child: child),
      ),
    );
  }
}
