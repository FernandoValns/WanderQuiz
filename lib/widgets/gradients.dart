import 'package:flutter/material.dart';

class AppGradients {
  static const Color primaryLightGreen = Color(0xFFAED581);
  static const Color secondaryLightGreen = Color(0xFFC5E1A5);

  static const LinearGradient lightGreenHeaderGradient = LinearGradient(
    colors: [secondaryLightGreen, primaryLightGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static BoxDecoration headerBoxDecoration(Size size) {
    return BoxDecoration(
      gradient: lightGreenHeaderGradient,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(size.width * 0.08),
        bottomRight: Radius.circular(size.width * 0.08),
      ),
    );
  }
}
