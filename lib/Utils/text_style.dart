import 'package:coding_test/Utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // Title Text Style
  static TextStyle title = GoogleFonts.lexend(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: ColorUtils.mainColor
  );

  // Subtitle Text Style
  static TextStyle subtitle = GoogleFonts.lexend(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  // Body Text Style
  static TextStyle body = GoogleFonts.lexend(
    fontSize: 15,
  );

  // Error Text Style
  static TextStyle error = GoogleFonts.lexend(
    fontSize: 15,
    color: Colors.red,
  );

  // Button Text Style
  static TextStyle button = GoogleFonts.lexend(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
