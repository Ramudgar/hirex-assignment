// ignore: depend_on_referenced_packages
import 'package:hirexapp/model/job.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_job_response.g.dart';

@JsonSerializable()
class JobResponse {
  bool? success;
  List<Job>? jobs;

JobResponse({this.success, this.jobs});

  factory JobResponse.fromJson(Map<String, dynamic> json) =>
      _$JobResponseFromJson(json);

  Map<String, dynamic> toJson() => _$JobResponseToJson(this);
}

