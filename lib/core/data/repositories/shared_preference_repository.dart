import 'dart:convert';
import 'package:auto/core/data/models/apis/token_info.dart';
import 'package:auto/core/enums/data_type.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceRepository {
  SharedPreferences globalSharedPrefs = Get.find();
  String prefFirstLanch = 'first_lanuch';
  String prefIsLoggedIn = 'login';
  String prefTokenInfo = 'token_info';
  String prefAppLang = 'app_language';

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
}
