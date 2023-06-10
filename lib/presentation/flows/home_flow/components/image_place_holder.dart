import 'package:flutter/material.dart';

class ImagePlaceHolder extends StatelessWidget {
  const ImagePlaceHolder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'lib/assets/placeholder.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
