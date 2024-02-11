class TokenInfo {
  String? accessToken;

  TokenInfo({this.accessToken});

  TokenInfo.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['accessToken'] = accessToken;
    return data;
  }
}