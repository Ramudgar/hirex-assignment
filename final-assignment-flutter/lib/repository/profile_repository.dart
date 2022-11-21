import 'dart:io';

import 'package:hirexapp/api/profile_api.dart';
import 'package:hirexapp/model/profile.dart';
import 'package:hirexapp/response/get_profile_response.dart';

class ProfileRepository {
  Future<bool> addProfile(File? file, Profile profile) async {
    return ProfileAPI().addProfile(file, profile);
  }

  Future<bool> updateProfile(File? file, Profile profile) async {
    return ProfileAPI().updateProfile(file, profile);
  }

  Future<ProfileResponse?> getProfile() async {
    return ProfileAPI().getProfile();
  }
}
