import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


part 'font.dart';

TextTheme appTextTheme(TextTheme base, Color textColor) => base.copyWith(
  headlineLarge: base.headlineLarge?.copyWith(

    fontSize: _FontSize.huge,

    ///77
   // fontFamily: _sFAlexandriaFamily,
    fontWeight: _semiBold,
    letterSpacing: 0,
  ),
  displayLarge: base.displayLarge?.copyWith(
    fontSize: _FontSize.heading_01,
    fontWeight: _semiBold,
    letterSpacing: 0,
    fontFamily: _sFDisplayBoldFamily,
  ),
  displayMedium: base.displayMedium?.copyWith(

    fontSize: _FontSize.heading_02,

    /// 36
    fontWeight: _light,
    letterSpacing: 0,
    fontFamily: _sFDisplayLightFamily,
  ),
  displaySmall: base.displaySmall?.copyWith(
    fontSize: _FontSize.heading_03,
    fontWeight: _bold,
    letterSpacing: 0,
    fontFamily: _sFDisplayLightFamily,
  ),
  headlineMedium: base.headlineMedium?.copyWith(

    fontSize: _FontSize.heading_04,

    /// 24
    fontWeight: _regular,
    letterSpacing: 0,
    fontFamily: _sFDisplayLightFamily,
  ),
  headlineSmall: base.headlineSmall?.copyWith(

    fontSize: _FontSize.heading_05,

    /// 20
    fontWeight: _bold,
    letterSpacing: 0,
    fontFamily: _sFDisplayLightFamily,
  ),
  titleLarge: base.titleLarge?.copyWith(

    fontSize: _FontSize.heading_06,

    /// 22
    fontWeight: _medium,
    letterSpacing: 0,
   // fontFamily: _sFAlexandriaFamily,
  ),
  titleMedium: base.titleMedium?.copyWith(

    fontSize: _FontSize.subtitle_01,

    /// 18
    fontWeight: _bold,
    letterSpacing: 0,
   // fontFamily: _sFAlexandriaFamily,
  ),
  titleSmall: base.titleSmall?.copyWith(

    fontSize: _FontSize.subtitle_02,

    /// 16
    fontWeight: _bold,
    letterSpacing: 0,
  //  fontFamily: _sFAlexandriaFamily,
  ),
  // titleMedium: base.titleMedium?.copyWith(
  //
  //   fontSize: _FontSize.body_01,
  //
  //   /// 16
  //   fontWeight: _regular,
  //   letterSpacing: 0,
  //   //fontFamily: _sFAlexandriaFamily,
  // ),
  bodyMedium: base.bodyMedium?.copyWith(
    fontSize: _FontSize.body_02,

    /// 14
    fontWeight: _regular,
    letterSpacing: 0,
  //  fontFamily: _sFAlexandriaFamily,
  ),
  labelLarge: base.labelLarge?.copyWith(
    fontSize: _FontSize.button,

    /// 18
    fontWeight: _bold,
    letterSpacing: 0,
    fontFamily: _sFDisplayLightFamily,
  ),
  bodySmall: base.bodySmall?.copyWith(
    fontSize: _FontSize.caption,

    /// 12
    fontWeight: _regular,
    letterSpacing: 0,
    fontFamily: _sFDisplayLightFamily,
  ),
  labelSmall: base.labelSmall?.copyWith(
    fontSize: _FontSize.overline,

    /// 10
    fontWeight: _regular,
    letterSpacing: 0,
    fontFamily: _sFDisplayLightFamily,
  ),
)
    .apply(
  displayColor: textColor,
  bodyColor: textColor,
);