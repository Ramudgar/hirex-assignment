// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      experience: json['experience'] as String?,
      skills: json['skills'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      institutionName: json['institutionName'] as String?,
      degree: json['degree'] as String?,
      startYear: json['startYear'] as String?,
      endYear: json['endYear'] as String?,
      profilePic: json['profilePic'] as String?,
    )..id = json['_id'] as String?;

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'experience': instance.experience,
      'skills': instance.skills,
      'country': instance.country,
      'city': instance.city,
      'state': instance.state,
      'institutionName': instance.institutionName,
      'degree': instance.degree,
      'startYear': instance.startYear,
      'endYear': instance.endYear,
      'profilePic': instance.profilePic,
    };
