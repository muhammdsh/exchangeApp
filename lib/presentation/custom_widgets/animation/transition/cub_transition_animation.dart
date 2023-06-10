import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../app+injection/di.dart';
import '../../../../core/resources/colors.dart';

class Pseudo3dRouteBuilder extends PageRouteBuilder {
  final Widget enterPage;
  final Widget exitPage;
  Pseudo3dRouteBuilder(this.exitPage, this.enterPage)
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => enterPage,
    transitionsBuilder: _transitionsBuilder(exitPage, enterPage),
  );

  static _transitionsBuilder(exitPage, enterPage) =>
          (context, animation, secondaryAnimation, child) {
        return Stack(
          children: <Widget>[
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset.zero,
                end: const Offset(-1.0, 0.0),
              ).animate(animation),
              child: Container(
                color: locator<AppThemeColors>().backgroundColor,
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.003)
                    ..rotateY(pi / 2 * animation.value),
                  alignment: FractionalOffset.centerRight,
                  child: exitPage,
                ),
              ),
            ),
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: Container(
                color: locator<AppThemeColors>().backgroundColor,
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.003)
                    ..rotateY(pi / 2 * (animation.value - 1)),
                  alignment: FractionalOffset.centerLeft,
                  child: enterPage,
                ),
              ),
            )
          ],
        );
      };
}