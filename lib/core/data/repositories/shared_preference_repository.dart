import 'dart:convert';
import 'package:auto/core/data/models/apis/token_info.dart';
import 'package:auto/core/enums/data_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceRepository {
  SharedPreferences globalSharedPrefs = Get.find();
  String prefFirstLanch = 'first_lanuch';
  String prefIsLoggedIn = 'login';
  String prefTokenInfo = 'token_info';
  String showCaseCounter = "showCaseCounter";
  String prefAppLang = 'app_language';

  setshowCaseCounter(int value) {
    setPreferance(
      dataType: DataType.int,
      key: showCaseCounter,
      value: value,
    );
  }

  int? getshowCaseCounter() {
    if (globalSharedPrefs.containsKey(showCaseCounter)) {
      return getPrefrance(key: prefTokenInfo);
    } else {
      return 0;
    }
  }


  setTokenInfo(TokenInfo value) {
    setPreferance(
      dataType: DataType.string,
      key: prefTokenInfo,
      value: jsonEncode(value),
    );
  }

  TokenInfo? getTokenInfo() {
    if (globalSharedPrefs.containsKey(prefTokenInfo)) {
      return TokenInfo.fromJson(jsonDecode(getPrefrance(key: prefTokenInfo)));
    } else {
      return null;
    }
  }

  setIsLoggedIN(bool value) {
    setPreferance(
      dataType: DataType.bool,
      key: prefIsLoggedIn,
      value: value,
    );
  }

  bool getIsLoggedIn() {
    if (globalSharedPrefs.containsKey(prefIsLoggedIn)) {
      return getPrefrance(key: prefIsLoggedIn);
    } else {
      return false;
    }
  }

  setFirstLanuch(bool value) {
    setPreferance(
      dataType: DataType.bool,
      key: prefFirstLanch,
      value: value,
    );
  }

  bool getFirstLanuch() {
    if (globalSharedPrefs.containsKey(prefFirstLanch)) {
      return getPrefrance(key: prefFirstLanch);
    } else {
      return true;
    }
  }

  setAppLanguage(String value) {
    setPreferance(
      dataType: DataType.string,
      key: prefAppLang,
      value: value,
    );
  }

  String getAppLanguage() {
    if (globalSharedPrefs.containsKey(prefAppLang)) {
      return getPrefrance(key: prefAppLang);
    } else {
      return 'ar';
    }
  }

  setPreferance({
    required DataType dataType,
    required String key,
    required dynamic value,
  }) async {
    switch (dataType) {
      case DataType.int:
        await globalSharedPrefs.setInt(key, value);
        break;
      case DataType.bool:
        await globalSharedPrefs.setBool(key, value);
        break;
      case DataType.string:
        await globalSharedPrefs.setString(key, value);
        break;
      case DataType.double:
        await globalSharedPrefs.setDouble(key, value);
        break;
      case DataType.listString:
        await globalSharedPrefs.setStringList(key, value);
        break;
    }
  }

  dynamic getPrefrance({required String key}) {
    return globalSharedPrefs.get(key);
  }

  void saveThemeMode(ThemeMode themeMode) {
    String themeModeKey = 'themeMode';
    String themeModeValue = themeModeToString(themeMode);
    setPreferance(
      dataType: DataType.string,
      key: themeModeKey,
      value: themeModeValue,
    );
  }

  ThemeMode getSavedThemeMode() {
    String themeModeKey = 'themeMode';
    String? savedThemeMode = getPrefrance(key: themeModeKey);
    return themeModeFromString(savedThemeMode);
    }

// Function to convert ThemeMode enum to string
  String themeModeToString(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return 'system';
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      default:
        return 'system';
    }
  }

// Function to convert string to ThemeMode enum
  ThemeMode themeModeFromString(String? themeModeString) {
    switch (themeModeString) {
      case 'system':
        return ThemeMode.system;
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
}
}
