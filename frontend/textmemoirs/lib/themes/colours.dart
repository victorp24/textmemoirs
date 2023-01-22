import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

const PrimaryColor = const Color(0xFF6B6054);
const PrimaryColorLight = const Color(0xFF929487);
const PrimaryColorDark = const Color(0xFFA1B0AB);

const SecondaryColor = const Color(0xFFC3DAC3);
const SecondaryColorLight = const Color(0xFFD5ECD4);
const SecondaryColorDark = const Color(0xFFA7C4A7);

const Background = const Color(0xFFfffdf7);
const TextColor = const Color(0xFFffffff);

class MyTheme {
  static final ThemeData defaultTheme = _buildMyTheme();

  static ThemeData _buildMyTheme() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      accentColor: SecondaryColor,
      accentColorBrightness: Brightness.dark,
      primaryColor: PrimaryColor,
      primaryColorDark: PrimaryColorDark,
      primaryColorLight: PrimaryColorLight,
      primaryColorBrightness: Brightness.dark,
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: SecondaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      scaffoldBackgroundColor: Background,
      cardColor: Background,
      textSelectionColor: PrimaryColorLight,
      backgroundColor: Background,
      textTheme: base.textTheme.copyWith(
          title: base.textTheme.title.copyWith(color: TextColor),
          body1: base.textTheme.body1.copyWith(color: TextColor),
          body2: base.textTheme.body2.copyWith(color: TextColor)),
    );
  }
}
