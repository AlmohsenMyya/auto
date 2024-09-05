import 'dart:convert';
import 'dart:developer';
import 'package:auto/core/enums/request_type.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

class NetworkUtil {
  static String baseUrl = 'training.owner-tech.com';
  static var client = http.Client();

  static Future<dynamic> sendRequest({
    required RequestType type,
    required String url,
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      var uri = Uri.https(baseUrl, url, params);
      late http.Response response;

      Map<String, dynamic> jsonRespons = {};

      switch (type) {
        case RequestType.get:
          response = await client.get(uri, headers: headers);
          break;
        case RequestType.post:
          response = await client.post(uri, headers: headers, body: jsonEncode(body));
          break;
        case RequestType.put:
          response = await client.put(uri, headers: headers, body: jsonEncode(body));
          break;
        case RequestType.delete:
          response = await client.delete(uri, headers: headers, body: jsonEncode(body));
          break;
        case RequestType.multiPart:
          break;
      }

      dynamic result;
      try {
        result = jsonDecode(utf8.decode(response.bodyBytes));
      } catch (e) {
        log(e.toString());
      }

      jsonRespons.putIfAbsent('statusCode', () => response.statusCode);
      jsonRespons.putIfAbsent(
          'response', () => result != null ? result : {'title': utf8.decode(response.bodyBytes)});

      return jsonRespons;
    } catch (e) {
      // debugPrint(e.toString());
      log(e.toString());

      BotToast.showText(text: e.toString());
    }
  }

  static MediaType getContentType(String name) {
    var ext = name.split('.').last;
    if (ext == "png" || ext == "jpeg") {
      return MediaType.parse("image/jpg");
    } else if (ext == 'pdf') {
      return MediaType.parse("application/pdf");
    } else {
      return MediaType.parse("image/jpg");
    }
  }
}
