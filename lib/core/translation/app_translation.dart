import 'package:auto2/core/translation/languages/ar_languages.dart';
import 'package:auto2/core/translation/languages/en_languages.dart';
import 'package:get/get.dart';

class AppTranlation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": ENLanguage.map,
        "ar_SA": ARLanguage.map,
      };
}

tr(String key) => key.tr;