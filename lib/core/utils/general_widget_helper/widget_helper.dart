import 'package:flutter/material.dart';

Size getWidgetSize(GlobalKey key) {
  final RenderBox renderBox = key.currentContext?.findRenderObject();
  return renderBox?.size;
}