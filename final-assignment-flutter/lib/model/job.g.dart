// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Job _$JobFromJson(Map<String, dynamic> json) => Job(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      maxApplicants: json['maxApplicants'] as num?,
      maxPositions: json['maxPositions'] as num?,
      location: json['location'] as String?,
      dateOfPosting: json['dateOfPosting'] as String?,
      deadline: json['deadline'] as String?,
      skills: json['skills'] as String?,
      duration: json['duration'] as String?,
      salary: json['salary'] as String?,
      rating: json['rating'] as num?,
      jobType: json['jobType'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      status: json['status'] as String?,
      apply: json['apply'] as String?,
    );

Map<String, dynamic> _$JobToJson(Job instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'maxApplicants': instance.maxApplicants,
      'maxPositions': instance.maxPositions,
      'location': instance.location,
      'dateOfPosting': instance.dateOfPosting,
      'deadline': instance.deadline,
      'skills': instance.skills,
      'duration': instance.duration,
      'salary': instance.salary,
      'rating': instance.rating,
      'jobType': instance.jobType,
      'image': instance.image,
      'description': instance.description,
      'status': instance.status,
      'apply': instance.apply,
    };
