
import 'package:flutter/material.dart';

import 'custom_theme/appbar_theme.dart';
import 'custom_theme/bottom_sheet_theme.dart';
import 'custom_theme/checkbox_theme.dart';
import 'custom_theme/chip_theme.dart';
import 'custom_theme/elevatedd_button_theme.dart';
import 'custom_theme/outlined_bottoms.dart';
import 'custom_theme/text_field_theme.dart';
import 'custom_theme/text_theme.dart';

class TAppTheme{
TAppTheme._();
static ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
primaryColor: Colors.blue,
  textTheme: TTextTheme.lightTextTheme,
  chipTheme: TChipTheme.lightChipTheme,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: TAppBar.lightAppBarTheme,
  checkboxTheme: TCheckbok_Theme.lightCheckboxTheme,
  bottomSheetTheme:  TBottomSheetTheme.lightBottomSheetTheme,
  elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
  outlinedButtonTheme: TOutlinedButton.lightOutButtomThem,
  inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme
);
static ThemeData darkTheme = ThemeData(
useMaterial3: true,
brightness: Brightness.dark,
primaryColor: Colors.blue,
textTheme: TTextTheme.darkTextTheme,
chipTheme: TChipTheme.darkChipTheme,
scaffoldBackgroundColor: Colors.black,
appBarTheme: TAppBar.darkAppBarTheme,
checkboxTheme: TCheckbok_Theme.darkCheckboxTheme,
bottomSheetTheme:  TBottomSheetTheme.darkBottomSheetTheme,
elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
outlinedButtonTheme: TOutlinedButton.darkOutButtomThem,
inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
);

}