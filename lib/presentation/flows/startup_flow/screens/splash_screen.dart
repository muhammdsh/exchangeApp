import 'package:exchange/app+injection/di.dart';
import 'package:exchange/core/helper/screen_util/screen_helper.dart';
import 'package:exchange/core/resources/colors.dart';
import 'package:exchange/core/resources/constants.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool data = false;

  @override
  Widget build(BuildContext context) {
    ScreensHelper(context);
    return Scaffold(
      body: GradientBackground(
        beginColor: locator<AppThemeColors>().gradientStarts,
        endColor: locator<AppThemeColors>().gradientEnds,
        child: Center(
          child: Image.asset(
            ImagesKeys.smallLogo,

          ),
        ),
      ),

    );
  }
}

class GradientBackground extends StatelessWidget {
  final Color beginColor;
  final Color endColor;
  final Widget child;

  const GradientBackground({
    @required this.beginColor,
    @required this.endColor,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            beginColor,
            endColor,
          ],
        ),
      ),
      child: child,
    );
  }
}
