// To parse this JSON data, do
//
//     final indexNotificationModel = indexNotificationModelFromJson(jsonString);

import 'dart:convert';

IndexNotificationModel indexNotificationModelFromJson(String str) =>
    IndexNotificationModel.fromJson(json.decode(str));

String indexNotificationModelToJson(IndexNotificationModel data) =>
    json.encode(data.toJson());

class IndexNotificationModel {
  final bool success;
  final Data data;

  IndexNotificationModel({
    required this.success,
    required this.data,
  });

  factory IndexNotificationModel.fromJson(Map<String, dynamic> json) =>
      IndexNotificationModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  final List<NotificationModel> notifications;
  final int total;

  Data({
    required this.notifications,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        notifications: List<NotificationModel>.from(
            json["notifications"].map((x) => NotificationModel.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "notifications":
            List<dynamic>.from(notifications.map((x) => x.toJson())),
        "total": total,
      };
}

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  final int? id;
  final int? type;
  final String? title;
  final String? body;
  final int? postId;
  final String? url;
  final bool? isWatched;

  NotificationModel({
    this.id,
    this.type,
    this.title,
    this.body,
    this.postId,
    this.url,
    this.isWatched,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        type: json["type"],
        title: json["title"],
        body: json["body"],
        postId: json["post_id"],
        url: json["url"],
        isWatched: json["is_watched"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "title": title,
        "body": body,
        "post_id": postId,
        "url": url,
        "is_watched": isWatched,
      };
}
// Notification model based on the given JSON response
class NotificationResponse {
  final int? id;
  final String title;
  final String body;
  final int branchId;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationResponse({
    this.id,
    required this.title,
    required this.body,
    required this.branchId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      branchId: json['branch_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'branch_id': branchId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

