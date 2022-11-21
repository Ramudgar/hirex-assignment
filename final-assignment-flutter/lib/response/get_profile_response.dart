// ignore: depend_on_referenced_packages
import 'package:hirexapp/model/profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  bool? success;
  List<Profile>? profile;

  ProfileResponse({this.success, this.profile});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}
