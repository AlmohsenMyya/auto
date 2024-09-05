import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/data/models/notification_model.dart';

class NotificationMohsenService {
  // Replace with your actual API endpoint
  static const String _apiUrl = 'https://auto-sy.com/api/notifications/';

  // Function to fetch notifications from API
  static Future<List<NotificationResponse>> fetchNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String myCode = prefs.getString("code_id") ?? "000";
    final response = await http.get(Uri.parse(_apiUrl+myCode));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((notification) => NotificationResponse.fromJson(notification))
          .toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }
}
