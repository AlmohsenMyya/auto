

import 'package:auto2/core/enums/request_type.dart';
import 'package:auto2/core/utils/general_util.dart';

class NetworkConfig {
  static String baseAPI = 'api/web/';

  static String getFulApiUrl(String api) {
    return baseAPI + api;
  }

  static Map<String, String> getHeaders(
      {bool isMultipartRequest = false,
      bool? needAuth = true,
      RequestType? type = RequestType.post,
      Map<String, String>? extraHeaders = const {}}) {
    return {
      if (needAuth!)
        'Authorization': 'Bearer ${storage.getTokenInfo()?.accessToken ?? ''}',
      if (type != RequestType.get && isMultipartRequest == false)
        'Content-Type': 'application/json',
      ...extraHeaders!
    };
  }
}