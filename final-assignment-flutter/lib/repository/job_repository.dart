import 'dart:io';

import 'package:hirexapp/api/job_api.dart';
import 'package:hirexapp/model/job.dart';
import 'package:hirexapp/response/get_job_response.dart';

class JobRepository {
  Future<bool> addJob(File? file, Job job) async {
    return JobAPI().addJob(file, job);
  }

  Future<JobResponse?> getJob() async {
    return JobAPI().getJob();
  }

  // get All jobs for user
  Future<JobResponse?> getAllJob() async {
    return JobAPI().getAllJob();
  }

// update joh
  Future<bool> updateJob(File? file, Job job) async {
    return JobAPI().updateJob(file, job);
  }

  // update job while applying for job
  Future<bool> applyUpdate(Job job) async {
    return JobAPI().applyJob(job);
  }

  // update job while applying for job
  Future<bool> jobAccept(Job job) async {
    return JobAPI().applyJob(job);
  }

  // update job while applying for job
  Future<bool> jobReject(Job job) async {
    return JobAPI().applyJob(job);
  }

// get applied job for user
  Future<JobResponse?> getAppliedJob() async {
    return JobAPI().getAppliedJob();
  }

// get job by comapny and applicants id
  Future<JobResponse?> getJobByUserId() async {
    return JobAPI().getJobByUserId();
  }

// delete job by id
  Future<bool> deleteJob(Job job) async {
    return JobAPI().deleteJob(job);
  }
}
