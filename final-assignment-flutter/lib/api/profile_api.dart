import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hirexapp/api/http_services.dart';
import 'package:hirexapp/controller/auth_controller.dart';
import 'package:hirexapp/model/profile.dart';
import 'package:hirexapp/response/get_profile_response.dart';
import 'package:hirexapp/utils/url.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

// ignore: depend_on_referenced_packages

class ProfileAPI {
  // add profile function
  Future<bool> addProfile(File? file, Profile profile) async {
    try {
      var dio = HttpServices().getDioInstance();
      MultipartFile? image;

      if (file != null) {
        var mimeType = lookupMimeType(file.path);
        image = await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last,
            contentType: MediaType("image", mimeType!.split('/')[1]));
      }

      var formData = FormData.fromMap({
        "name": profile.name,
        "phone": profile.phone,
        "experience": profile.experience,
        "skills": profile.skills,
        "country": profile.country,
        "city": profile.city,
        "state": profile.state,
        "institutionName": profile.institutionName,
        "degree": profile.degree,
        "startYear": profile.startYear,
        "endYear": profile.endYear,
        "profilePic": image,
      });
      final token = await Authcontroller.getAuthToken();
      var response = await dio.post(
        profileUrl,
        data: formData,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    }

    return true;
  }

  // edit profile function
  Future<bool> updateProfile(File? file, Profile profile) async {
    try {
      var dio = HttpServices().getDioInstance();
      MultipartFile? image;

      if (file != null) {
        var mimeType = lookupMimeType(file.path);
        image = await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last,
            contentType: MediaType("image", mimeType!.split('/')[1]));
      }

      var formData = FormData.fromMap({
        "name": profile.name,
        "phone": profile.phone,
        "experience": profile.experience,
        "skills": profile.skills,
        "country": profile.country,
        "city": profile.city,
        "state": profile.state,
        "institutionName": profile.institutionName,
        "degree": profile.degree,
        "startYear": profile.startYear,
        "endYear": profile.endYear,
        "profilePic": image,
      });
      final token = await Authcontroller.getAuthToken();
      var response = await dio.put(
        updateProfileUrl,
        data: formData,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    }

    return true;
  }

// get profile function
  Future<ProfileResponse?> getProfile() async {
    Future.delayed(const Duration(seconds: 2),
        () {}); /* wating for two seconds to display the progress bar */
    ProfileResponse? profileResponse;
    try {
      var dio = HttpServices().getDioInstance();
      final token = await Authcontroller.getAuthToken();

      Response response = await dio.get(
        getProfileUrl,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );
      if (response.statusCode == 200) {
        profileResponse = ProfileResponse.fromJson(response.data);
      } else {
        profileResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return profileResponse;
  }
}
