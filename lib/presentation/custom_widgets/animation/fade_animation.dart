import 'package:flutter/cupertino.dart';

class FadeAnimation extends StatefulWidget {
  const FadeAnimation({Key key, this.duration, this.child}) : super(key: key);
  final int duration;
  final Widget child;

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        duration: Duration(milliseconds: widget.duration),
        vsync: this,
        lowerBound: 0.0,
        upperBound: 2.0)
      ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        child: widget.child,
        builder: (context, child) {
          return Opacity(
            opacity: (controller.value - 1).abs()
            ,
            child: child,
          );
        });
  }
}
