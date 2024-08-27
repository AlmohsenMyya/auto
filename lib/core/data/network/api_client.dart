import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;

  ApiClient({required this.baseUrl});

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final response = await http.post(url, body: json.encode(body),
        headers: {
      'Content-Type': 'application/json',
    }
    );
    print("backUpdebug $baseUrl/$endpoint $body ${response.statusCode}");
    return _handleResponse(response, baseUrl+endpoint);
  }

  Future<http.Response> delete(String endpoint, {Map<String, dynamic>? params}) async {
    final url = Uri.parse('$baseUrl/$endpoint').replace(queryParameters: params);
    final response = await http.delete(url, headers: {
      'Content-Type': 'application/json',
    });
    return _handleResponse(response , baseUrl+endpoint);
  }

  http.Response _handleResponse(http.Response response , String url) {
    if (response.statusCode >= 200 && response.statusCode < 303) {
      return response;
    } else {
      print('backUpdebug $url Failed to load data: ${response.statusCode} ${response.body}');
      throw Exception('Failed to load data: ${response.statusCode} ');
    }
  }
}
