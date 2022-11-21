import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hirexapp/controller/auth_controller.dart';
import 'package:hirexapp/model/user.dart';
import 'package:hirexapp/response/login_response.dart';
import 'package:hirexapp/utils/url.dart';

import 'http_services.dart';

class UserAPI {
  Future<bool> registerUser(User user) async {
    bool isLogin = false;
    Response response;
    var url = baseUrl + registerUrl;
    var dio = HttpServices().getDioInstance();
    try {
      response = await dio.post(
        url,
        data: user.toJson(),
      );
      if (response.statusCode == 200 && response.statusMessage == "OK") {
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isLogin;
  }

  Future<bool> login(String email, String password, String role) async {
    bool isLogin = false;
    try {
      var url = baseUrl + userLoginUrl;
      var dio = HttpServices().getDioInstance();

      var response = await dio.post(url, data: {
        "email": email,
        "password": password,
        "role": role,
      });
      debugPrint(response.statusCode.toString());

      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);

        token = loginResponse
            .token; // this is the token that we will use to get the user details and it is generated at the time of login and it is stored in the local device in the form of a string and we will use this token to get logged in automatically when we open the app and it will be stored in the shared preferences.

// Authcontroller is a instance of the class in the controller folder that has function to store token in a shared preference
        Authcontroller().setAuthToken(token!);

//save email and password in shared preferences

        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return isLogin;
  }
}
