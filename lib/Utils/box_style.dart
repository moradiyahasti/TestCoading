import 'package:flutter/material.dart';

class AppBoxStyles {
  static BoxDecoration cardBoxDecoration(bool isHovered) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: isHovered ? 10 : 4,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  static const EdgeInsets cardPadding = EdgeInsets.all(16.0);

  static const EdgeInsets cardMargin = EdgeInsets.all(10.0);

  static BoxDecoration containerBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 3),
      ),
    ],
  );
}
