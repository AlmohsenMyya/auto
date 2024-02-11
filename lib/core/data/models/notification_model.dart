class NotificationModel {
  String? title;
  String? text;
  String? notificatioNType;
  String? model;

  NotificationModel({this.title, this.text, this.notificatioNType, this.model});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    text = json['text'];
    notificatioNType = json['notification_type'];
    model = json['model'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['text'] = text;
    data['notification_type'] = notificatioNType;
    data['model'] = model;
    return data;
  }
}