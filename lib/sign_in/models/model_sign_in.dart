class ModelSignIn {
  String? status;
  int? code;
  String? message;
  Data data;

  ModelSignIn({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory ModelSignIn.fromJson(Map<String, dynamic> json) => ModelSignIn(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String? branchCode;
  String? refreshToken;
  String? token;

  Data({
    required this.branchCode,
    required this.refreshToken,
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    branchCode: json["branch_code"],
    refreshToken: json["refresh_token"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "branch_code": branchCode,
    "refresh_token": refreshToken,
    "token": token,
  };
}
