class LoginResponse {
  bool? success;
  String? token;
  String? role;

  LoginResponse({this.success, this.token, this.role});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json["Success"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "Success": success,
        "token": token,
      };
}
