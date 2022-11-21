import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hirexapp/api/http_services.dart';
import 'package:hirexapp/controller/auth_controller.dart';
import 'package:hirexapp/model/job.dart';
import 'package:hirexapp/response/get_job_response.dart';
import 'package:hirexapp/utils/url.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

// ignore: depend_on_referenced_packages

class JobAPI {
  // api to add job
  Future<bool> addJob(File? file, Job job) async {
    try {
      var dio = HttpServices().getDioInstance();
      MultipartFile? image;

      if (file != null) {
        var mimeType = lookupMimeType(file.path);
        image = await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last,
            contentType: MediaType("image", mimeType!.split('/')[1]));
      }

      var formData = FormData.fromMap({
        "title": job.title,
        "maxApplicants": job.maxApplicants,
        "maxPositions": job.maxPositions,
        "location": job.location,
        "dateOfPosting": job.dateOfPosting,
        "deadline": job.deadline,
        "skills": job.skills,
        "duration": job.duration,
        "salary": job.salary,
        "rating": job.rating,
        "jobType": job.jobType,
        "description": job.description,
        "image": image,
      });
      final token = await Authcontroller.getAuthToken();
      var response = await dio.post(
        jobUrl,
        data: formData,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    }

    return true;
  }

// api to update job with job id
  Future<bool> updateJob(File? file, Job job) async {
    try {
      var dio = HttpServices().getDioInstance();
      MultipartFile? image;

      if (file != null) {
        var mimeType = lookupMimeType(file.path);
        image = await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last,
            contentType: MediaType("image", mimeType!.split('/')[1]));
      }

      var formData = FormData.fromMap({
        // "id": job.id,
        "title": job.title,
        "maxApplicants": job.maxApplicants,
        "maxPositions": job.maxPositions,
        "location": job.location,
        "dateOfPosting": job.dateOfPosting,
        "deadline": job.deadline,
        "skills": job.skills,
        "duration": job.duration,
        "salary": job.salary,
        "rating": job.rating,
        "jobType": job.jobType,
        "description": job.description,
        "image": image,
      });
      final token = await Authcontroller.getAuthToken();
      // print(updateJobUrl + job.id!);
      var response = await dio.put(
        updateJobUrl + job.id!,
        data: formData,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    }

    return true;
  }

  // update job while clicking applybutton

  Future<bool> applyJob(Job job) async {
    try {
      var dio = HttpServices().getDioInstance();

      var formData = FormData.fromMap({});
      final token = await Authcontroller.getAuthToken();
      // print(updateJobUrl + job.id!);
      var response = await dio.put(
        applyUpdate + job.id!,
        data: formData,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    }

    return true;
  }



  Future<bool> acceptJob(Job job) async {
    try {
      var dio = HttpServices().getDioInstance();

      var formData = FormData.fromMap({});
      final token = await Authcontroller.getAuthToken();
      // print(updateJobUrl + job.id!);
      var response = await dio.put(
        statusAccepted + job.id!,
        data: formData,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    }

    return true;
  }




  Future<bool> rejectJob(Job job) async {
    try {
      var dio = HttpServices().getDioInstance();

      var formData = FormData.fromMap({});
      final token = await Authcontroller.getAuthToken();
      // print(updateJobUrl + job.id!);
      var response = await dio.put(
       statusRejected+ job.id!,
        data: formData,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    }

    return true;
  }

Future<bool> deleteJob(Job job) async {
    try {
      var dio = HttpServices().getDioInstance();

      final token = await Authcontroller.getAuthToken();
      // print(updateJobUrl + job.id!);
      var response = await dio.delete(
       deleteJobUrl+ job.id!,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    }

    return true;
  }





// get job by user company id
  Future<JobResponse?> getJob() async {
    Future.delayed(const Duration(seconds: 2),
        () {}); /* wating for two seconds to display the progress bar */
    JobResponse? jobResponse;
    try {
      var dio = HttpServices().getDioInstance();
      final token = await Authcontroller.getAuthToken();

      Response response = await dio.get(
        getJobUrl,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );
      if (response.statusCode == 200) {
        jobResponse = JobResponse.fromJson(response.data);
      } else {
        jobResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return jobResponse;
  }

  Future<JobResponse?> getAllJob() async {
    Future.delayed(const Duration(seconds: 2),
        () {}); /* wating for two seconds to display the progress bar */
    JobResponse? jobResponse;
    try {
      var dio = HttpServices().getDioInstance();
      final token = await Authcontroller.getAuthToken();

      Response response = await dio.get(
        getJobAllUrl,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );
      if (response.statusCode == 200) {
        jobResponse = JobResponse.fromJson(response.data);
      } else {
        jobResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return jobResponse;
  }

// get job by Applicants id while applying the job

 Future<JobResponse?> getAppliedJob() async {
    Future.delayed(const Duration(seconds: 2),
        () {}); /* wating for two seconds to display the progress bar */
    JobResponse? jobResponse;
    try {
      var dio = HttpServices().getDioInstance();
      final token = await Authcontroller.getAuthToken();

      Response response = await dio.get(
        getAppliedJobUrl,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );
      if (response.statusCode == 200) {
        jobResponse = JobResponse.fromJson(response.data);
      } else {
        jobResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return jobResponse;
  }

// api to get job by company id and applicant id
Future<JobResponse?> getJobByUserId() async {
    Future.delayed(const Duration(seconds: 2),
        () {}); /* wating for two seconds to display the progress bar */
    JobResponse? jobResponse;
    try {
      var dio = HttpServices().getDioInstance();
      final token = await Authcontroller.getAuthToken();

      Response response = await dio.get(
        getJobByUserIdUrl,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );
      if (response.statusCode == 200) {
        jobResponse = JobResponse.fromJson(response.data);
      } else {
        jobResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return jobResponse;
  }


  // api to accept job by company id and applicant id

}
