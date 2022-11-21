import 'package:json_annotation/json_annotation.dart';

part 'job.g.dart';

@JsonSerializable()
class Job {
  @JsonKey(name: '_id')
  String? id;
  String? title;
  num? maxApplicants;
  num? maxPositions;
  String? location;
  String? dateOfPosting;
  String? deadline;
  String? skills;
  String? duration;
  String? salary;
  num? rating;
  String? jobType;
  // String? category;
  String? image;
  String? description;
  String? status;
  String? apply;

  Job({
    this.id,
    this.title,
    this.maxApplicants,
    this.maxPositions,
    this.location,
    this.dateOfPosting,
    this.deadline,
    this.skills,
    this.duration,
    this.salary,
    this.rating,
    this.jobType,
    // this.category,

    this.image,
    this.description,
    this.status,
    this.apply,
  });

//3. flutter pub run build_runner build
  factory Job.fromJson(Map<String, dynamic> json) {
    return _$JobFromJson(json);
  }

  Map<String, dynamic> toJson() => _$JobToJson(this);
}
