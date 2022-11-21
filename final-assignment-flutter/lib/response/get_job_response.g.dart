// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_job_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobResponse _$JobResponseFromJson(Map<String, dynamic> json) => JobResponse(
      success: json['success'] as bool?,
      jobs: (json['jobs'] as List<dynamic>?)
          ?.map((e) => Job.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JobResponseToJson(JobResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'jobs': instance.jobs,
    };
