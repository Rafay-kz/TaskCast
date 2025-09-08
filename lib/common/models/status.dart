class Status {
  int? code;
  String? message;
  String? description;

  Status({this.code, this.message, this.description});

  Status.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['description'] = description;
    return data;
  }
}