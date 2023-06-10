import 'package:flutter/cupertino.dart';

class Print {
  static final pattern = RegExp('.{1,800}');

  static void log({@required print}) {
    assert(print != null);
    pattern.allMatches(print).forEach((match) => print(match.group(0)));
  }
}