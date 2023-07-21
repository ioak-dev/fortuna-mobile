import 'package:flutter/material.dart';

Color getFontColorForBackground(Color color) {
  return (color.computeLuminance() > 0.179)? Colors.black : Colors.white;
}