class RegisterResponseModel {
  final String token;
  final String error;

  RegisterResponseModel({required this.token, required this.error});
  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
        token: json["token"] != null ? json["token"] : "",
        error: json["error"] != null ? json["error"] : "");
  }
}

class RegisterRequestModel {
  String userName;
  String email;
  String password;
  String confirmPassword;

  RegisterRequestModel(
      {required this.email,
      required this.password,
      required this.userName,
      required this.confirmPassword});

  Map<String, dynamic> tojson() {
    Map<String, dynamic> map = {
      'username': userName.trim(),
      'email': email.trim(),
      'password': password.trim(),
      'confirmPassword': confirmPassword.trim(),
    };

    return map;
  }
}
