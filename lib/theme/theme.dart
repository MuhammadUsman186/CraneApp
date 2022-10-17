import 'package:crane_master/theme/color.dart';
import 'package:flutter/material.dart';

final ThemeData kCraneTheme = _buildCraneTheme();

IconThemeData _customIconTheme(IconThemeData originalIcon, Color color) {
  return originalIcon.copyWith(color: color);
}

ThemeData _buildCraneTheme() {
  ThemeData baseTheme = ThemeData.light();

  return baseTheme.copyWith(
    colorScheme: ColorScheme.light().copyWith(
      primary: kCranePurple800,
      secondary: kCraneRed700,
    ),
    primaryColor: kCranePurple800,
    hintColor: kCraneWhite60,
    indicatorColor: kCranePrimaryWhite,
    scaffoldBackgroundColor: kCranePrimaryWhite,
    cardColor: kCranePurple700,
    errorColor: kCraneErrorOrange,
    highlightColor: Colors.transparent,
    buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
    textTheme: baseTheme.textTheme,
    primaryTextTheme: baseTheme.primaryTextTheme,
    iconTheme: _customIconTheme(baseTheme.iconTheme, kCraneWhite60),
    primaryIconTheme: _customIconTheme(baseTheme.iconTheme, kCranePrimaryWhite),
  );
}

TextTheme _buildCraneTextTheme(TextTheme base) {
  return base.copyWith(
      headline1: base.headline1.copyWith(
        fontWeight: FontWeight.w300,
        fontSize: 96,
      ),
      headline2: base.headline2.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 60,
      ),
      headline3: base.headline3.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 48,
      ),
      headline4: base.headline4.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 34,
      ),
      headline5: base.headline5.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
      headline6: base.headline6.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      subtitle1: base.subtitle1.copyWith(
          fontWeight: FontWeight.w500, fontSize: 16, letterSpacing: 0.5),
      subtitle2: base.subtitle2.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: kCraneGrey,
      ),
      bodyText1: base.bodyText1.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      bodyText2: base.bodyText2.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      button: base.button.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 13,
        letterSpacing: 0.8,
      ),
      caption: base.caption.copyWith(
          fontWeight: FontWeight.w500, fontSize: 12, color: kCraneGrey),
      overline: base.overline
          .copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          )
          .apply(fontFamily: 'Raleway'));
}
