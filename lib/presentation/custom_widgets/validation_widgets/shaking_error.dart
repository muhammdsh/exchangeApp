import 'package:exchange/presentation/custom_widgets/validation_widgets/shaking_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

enum ErrorAnimationProp { offset }

class ShakingErrorText extends StatelessWidget {
  final ShakingErrorController controller;
  final int timesToShake;
  final MultiTween<ErrorAnimationProp> _tween;

  ShakingErrorText({
    this.controller,
    this.timesToShake = 4,
  }) : _tween = MultiTween<ErrorAnimationProp>() {
    List.generate(
        timesToShake,
            (_) => _tween
          ..add(ErrorAnimationProp.offset, Tween<double>(begin: 0, end: 10), Duration(milliseconds: 100))
          ..add(ErrorAnimationProp.offset, Tween<double>(begin: 10, end: -10), Duration(milliseconds: 100))
          ..add(ErrorAnimationProp.offset, Tween<double>(begin: -10, end: 0), Duration(milliseconds: 100)));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShakingErrorController>.value(
      value: controller,
      child: Consumer<ShakingErrorController>(
        builder: (context, errorController, child) {
          return CustomAnimation<MultiTweenValues<ErrorAnimationProp>>(
            control: errorController.controlSignal,
            curve: Curves.easeOut,
            duration: _tween.duration,
            tween: _tween,
            animationStatusListener: (status) {
              if (status == AnimationStatus.forward) {
                controller.onAnimationStarted();
              }
            },
            builder: (BuildContext context, Widget child, tweenValues) {
              return Transform.translate(
                offset: Offset(tweenValues.get(ErrorAnimationProp.offset), 0),
                child: child,
              );
            },
            child: Visibility(
              visible: controller.isVisible && controller.isMounted,
              maintainSize: controller.isMounted,
              maintainAnimation: controller.isMounted,
              maintainState: controller.isMounted,
              child: Text(
                  errorController.errorText,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.red)
              ),
            ),
          );
        },
      ),
    );
  }
}