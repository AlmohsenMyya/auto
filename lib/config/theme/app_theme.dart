import 'package:auto/config/theme/typography.dart';
import 'package:flutter/material.dart';

part 'dark_color_scheme.dart';

part 'light_color_scheme.dart';

const defaultAppTheme = ThemeMode.light;

class AppTheme {
  static ThemeData get _builtInLightTheme => ThemeData.light();

  static ThemeData get _buildInDarkTheme => ThemeData.dark();

  static ThemeData get light {
    final textTheme =
        appTextTheme(_builtInLightTheme.textTheme, _lightColorScheme.primary);

    return _builtInLightTheme.copyWith(
      // primaryColorLight: Colors.blue  ,
      sliderTheme: SliderThemeData(
          activeTickMarkColor: Colors.teal,
          activeTrackColor: Colors.teal,
          valueIndicatorColor: Colors.teal,
          disabledActiveTickMarkColor: Colors.teal,
          disabledActiveTrackColor: Colors.teal,
          disabledInactiveTickMarkColor: Colors.teal,
          disabledInactiveTrackColor: Colors.teal,
          valueIndicatorTextStyle:
              textTheme.subtitle1!.copyWith(color: Colors.teal)),
      colorScheme: _lightColorScheme,
      textTheme: textTheme,
      useMaterial3: true,
      typography: Typography.material2018(),
      scaffoldBackgroundColor: _lightColorScheme.background,
      primaryColor: _lightColorScheme.primary,
    );
  }

  static ThemeData get dark {
    final textTheme =
        appTextTheme(_builtInLightTheme.textTheme, _darkColorScheme.primary);
    return _buildInDarkTheme.copyWith(
      colorScheme: _darkColorScheme,
      textTheme: textTheme,
      sliderTheme: SliderThemeData(
          activeTickMarkColor: Colors.teal,
          activeTrackColor: Colors.teal,
          valueIndicatorColor: Colors.teal,
          disabledActiveTickMarkColor: Colors.teal,
          disabledActiveTrackColor: Colors.teal,
          disabledInactiveTickMarkColor: Colors.teal,
          disabledInactiveTrackColor: Colors.teal,
          valueIndicatorTextStyle: TextStyle(color: Colors.black)),
      useMaterial3: true,
      typography: Typography.material2018(),
      scaffoldBackgroundColor: _lightColorScheme.background,
      primaryColor: _lightColorScheme.primary,
    );
  }
}
