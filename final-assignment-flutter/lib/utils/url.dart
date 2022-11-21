const baseUrl = "http://10.0.2.2:5000/";
// const baseUrl = "http://localhost:5000/"; //for testing on localhost

// const baseUrl = "http://172.25.0.180:5000/";

const registerUrl = "user/register/";
const userLoginUrl = "user/login/";
const jobUrl = "jobs/create";
const getJobUrl = "jobs/getByUser/";
const updateJobUrl = "jobs/update/";
const getJobAllUrl = "jobs/getAll/";
const categoryUrl = "category/getAll";
const profileUrl = "profile/create/";
const getProfileUrl = "profile/getByUser/";
const updateProfileUrl = "profile/update/";
const applyUpdate = "jobs/applyUpdate/";
const statusAccepted = 'jobs/statusUpdate/';
const statusRejected = 'jobs/statusRejected/';
const getAppliedJobUrl = "jobs/getByApplicants/";
// get job by company id and job applicants
const getJobByUserIdUrl = "jobs/getUserId/";
const deleteJobUrl = 'jobs/deleteById/';

String? token;
