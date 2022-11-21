

import 'package:hirexapp/model/category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job_category.g.dart';

//flutter pub run build_runner build
@JsonSerializable()
class JobCategory {
  @JsonKey(name: '_id')
  String? id;
  String? title;
  String? maxApplicants;
  String? maxPositions;
  String? location;
  String? dateOfPosting;
  String? deadline;
  String? skillSets;
  String? duration;
  String? salary;
  String? rating;
  String? jobType;
  Category? category;
  String? image;
  String? description;

  JobCategory({
    this.title,
    this.maxApplicants,
    this.maxPositions,
    this.location,
    this.dateOfPosting,
    this.deadline,
    this.skillSets,
    this.duration,
    this.salary,
    this.rating,
    this.jobType,
    this.description,
    this.image,
    this.category,
  });

  factory JobCategory.fromJson(Map<String, dynamic> json) =>
      _$JobCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$JobCategoryToJson(this);
}
