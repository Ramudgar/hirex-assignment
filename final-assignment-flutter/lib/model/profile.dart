import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? phone;
  String? experience;
  String? skills;
  String? country;
  String? city;
  String? state;
  String? institutionName;
  String? degree;
  String? startYear;
  String? endYear;
  String? profilePic;

  Profile(
      {this.name,
      this.phone,
      this.experience,
      this.skills,
      this.country,
      this.city,
      this.state,
      this.institutionName,
      this.degree,
      this.startYear,
      this.endYear,
      this.profilePic});

//3. flutter pub run build_runner build
  factory Profile.fromJson(Map<String, dynamic> json) {
    return _$ProfileFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
