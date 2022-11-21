// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobCategory _$JobCategoryFromJson(Map<String, dynamic> json) => JobCategory(
      title: json['title'] as String?,
      maxApplicants: json['maxApplicants'] as String?,
      maxPositions: json['maxPositions'] as String?,
      location: json['location'] as String?,
      dateOfPosting: json['dateOfPosting'] as String?,
      deadline: json['deadline'] as String?,
      skillSets: json['skillSets'] as String?,
      duration: json['duration'] as String?,
      salary: json['salary'] as String?,
      rating: json['rating'] as String?,
      jobType: json['jobType'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
    )..id = json['_id'] as String?;

Map<String, dynamic> _$JobCategoryToJson(JobCategory instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'maxApplicants': instance.maxApplicants,
      'maxPositions': instance.maxPositions,
      'location': instance.location,
      'dateOfPosting': instance.dateOfPosting,
      'deadline': instance.deadline,
      'skillSets': instance.skillSets,
      'duration': instance.duration,
      'salary': instance.salary,
      'rating': instance.rating,
      'jobType': instance.jobType,
      'category': instance.category,
      'image': instance.image,
      'description': instance.description,
    };
