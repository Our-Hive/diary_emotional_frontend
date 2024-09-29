import 'dart:math';

import 'package:flutter/material.dart';

class RandomColor {
  static Color generate() {
    final random = Random();
    final r = random.nextInt(255);
    final g = random.nextInt(255);
    final b = random.nextInt(255);
    return Color.fromRGBO(r, g, b, 1);
  }

  static Color generateByList(List<Color> colors) {
    final random = Random();
    return colors[random.nextInt(
      colors.length,
    )];
  }
}
