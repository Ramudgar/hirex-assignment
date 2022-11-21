const express = require('express');
const router = express.Router();
const auth = require('../auth/auth')
const Job = require('../models/job');
const image_upload = require('../middleware/upload');
const DOMAIN="http://localhost:5000/"
const mongoose = require('mongoose');



router.post(
  "/jobs/create",auth.verifyUser,
  image_upload.single("image"),
  async (req, res) => {
    try {
      if (req.file == undefined || req.file == null) {
        return res.status(400).json({
          status: "error",
          message: "No file selected",
        });
      }
      // req.userData contains all the data of the user
      userId=req.userData._id;
      // console.log(userId);
      let data=req.body;
let file = req.file;
// please remove public/ from the file name below if you want to upload and fetch the file thorough uploads folder
// for now I am fetching image from public/uploads
    let filename = DOMAIN + "public/uploads/" + file.filename;

      let job = new Job({
        userId,
        title: data.title,
        description: data.description,
        skills: data.skills,
        salary: data.salary,
        location: data.location,
        image: filename,
        category: data.category,
        maxApplicants: data.maxApplicants,
        maxPositions: data.maxPositions,
        dateOfPosting: data.dateOfPosting,
        deadline: data.deadline,
        jobType: data.jobType,
        duration: data.duration,
        status:data.status,
        jobApplicants:data.jobApplicants,
        jobApplicantsCount:data.jobApplicantsCount,
      });
      let savedjob = await job.save();
      return res.status(200).json({
        success: true,
        message: "job created successfully.",
        data: savedjob,
      });
    } catch (err) {
      return res.status(400).json({
        status: "error",
        message: "Unable to create job.",
      });
    }
  }
);


// update job by job id
router.put("/jobs/update/:idd",auth.verifyUser,image_upload.single('image'), async (req, res) => {
 
const data = req.body;
  
  if(req.file==undefined || req.file==null){
    try{
    const job = await Job.findByIdAndUpdate(
      req.params.idd,
      {
        
        title: data.title,
        description: data.description,
        skills: data.skills,
        salary: data.salary,
        location: data.location,
        category: data.category,
        maxApplicants: data.maxApplicants,
        maxPositions: data.maxPositions,
        dateOfPosting: data.dateOfPosting,
        deadline: data.deadline,
        jobType: data.jobType,
        duration: data.duration,
        status:data.status,
        jobApplicants:data.jobApplicants,
        jobApplicantsCount:data.jobApplicantsCount,
      },
      {
        new: true,
      }
    );

    if (!job) {
      res.status(500).json({
        success: false,
        message: "Update error",
      });
    } else {
      res.status(201).json({ success: true, data: job });
    }
  }catch(err){ return res.status(400).json({ success: false, message: "Unable to update job." });} }
  else{
    let file = req.file;
  let filename = DOMAIN + "public/uploads/" + file.filename;
    const job = await Job.findByIdAndUpdate(
      req.params.idd,
      {
        
        title: data.title,
        description: data.description,
        skills: data.skills,
        salary: data.salary,
        location: data.location,
        category: data.category,
        maxApplicants: data.maxApplicants,
        maxPositions: data.maxPositions,
        dateOfPosting: data.dateOfPosting,
        deadline: data.deadline,
        jobType: data.jobType,
        duration: data.duration,
        image:filename,
        status:data.status,
        jobApplicants:data.jobApplicants,
        jobApplicantsCount:data.jobApplicantsCount,
      },
      {
        new: true,
      }
    );

    if (!job) {
      res.status(500).json({
        success: false,
        message: "Update error",
      });
    } else {
      res.status(201).json({ success: true, data: job });
    }
  }
    
  }
);



// To get all jobs
router.get('/jobs/getAll',auth.verifyUser, (req, res) => {

  try {
    let jobs=Job.find({}).then((data) => {
      res.json({ success: true, msg: "jobs fetched successfully", jobs: data });
    }
    )
  }
  catch (e) {
    res.status(400).json({ msg: e });
  }

}
);





// find a single job with a job id.
router.get("/jobs/getById/:id", auth.verifyUser, (req, res) => {
  Job.findById(req.params.id)
    .then(data => {
      if (!data) {
        return res.status(404).send({
          success: false,
          message: "job not found with id " + req.params.id
        });
      }
      res.send({
        success: true,
        message: 'job successfully retrieved',
        data: data
      });
    }).catch(err => {
      if (err.kind === 'ObjectId') {
        return res.status(404).send({
          success: false,
          message: "job not found with id " + req.params.id
        });
      }
      return res.status(500).send({
        success: false,
        message: "Error retrieving job with id " + req.params.id
      });
    });
}
);



// get all jobs by user id
router.get("/jobs/getByUser", auth.verifyUser, async (req, res) => {
  try {
    let jobs = await Job.find({ userId: req.userData._id });
    return res.status(200).json({
      jobs,
      success: true,
      message: "jobs fetched successfully.",
    });
  } catch (err) {
    return res.status(400).json({
      success: false,
      message: "Unable to fetch jobs",
    });
  }
});


// get all applied jobs by jobApplicants id
router.get("/jobs/getByApplicants", auth.verifyUser, async (req, res) => {
  try {
    let jobs = await Job.find({ jobApplicants:req.userData._id  }).populate('jobApplicants');
    return res.status(200).json({
      jobs,
      success: true,
      message: "jobs fetched successfully.",
    });
  } catch (err) {
    return res.status(400).json({
      success: false,
      message: "Unable to fetch jobs",
    });
  }
}
);


// update job by job id for only to update job applicants
router.put("/jobs/applyUpdate/:id", auth.verifyUser, async (req, res) => {
  try {
    let job = await Job.findByIdAndUpdate(
      req.params.id,
      {
        jobApplicants:req.userData._id,
        status:req.body.status,
        jobApplicantsCount:req.body.jobApplicantsCount,
        apply:"Applied",
      },
      {
        new: true,
      }
    );

    if (!job) {
      res.status(500).json({
        success: false,
        message: "Update error",
      });

    } else {
      res.status(201).json({ success: true, data: job });
    }
  }
  catch (err) {
    return res.status(400).json({
      success: false,
      message: "Unable to update job.",
    });
  }
}
);

// update job by job id and applicants id 
router.put("/jobs/statusUpdate/:id", auth.verifyUser, async (req, res) => {
  try {
    let job = await Job.findByIdAndUpdate(
      req.params.id,
      {
        status:"Accepted",
      },
      {
        new: true,
      }
    );

    if (!job) {
      res.status(500).json({
        success: false,
        message: "Update error",
      });

    } else {
      res.status(201).json({ success: true, data: job });
    }
  }
  catch (err) {
    return res.status(400).json({
      success: false,
      message: "Unable to update job.",
    });
  }
}
);


// status rejected

router.put("/jobs/statusRejected/:id", auth.verifyUser, async (req, res) => {
  try {
    let job = await Job.findByIdAndUpdate(
      req.params.id,
      {
        status:"Rejected",
      },
      {
        new: true,
      }
    );
    if (!job) {
      res.status(500).json({
        success: false,
        message: "Update error",
      });

    } else {
      res.status(201).json({ success: true, data: job });
    }
  }
  catch (err) {
    return res.status(400).json({
      success: false,
      message: "Unable to update job.",
    });
  }
}
);





// jobs get by user id and populate it with user jobApplicants
router.get("/jobs/getUserId", auth.verifyUser, async (req, res) => {
  try {
    let jobs = await Job.find({$and:[{userId:req.userData._id},{ jobApplicants: { $exists: true, $not: {$size: 0} } }]}).populate("jobApplicants");
    // let jobs = await Job.find({$and:[{userId:req.userData._id},{ jobApplicants: { $exists: true, $not: {$size: 0} } }]}).populate("jobApplicants");
    return res.status(200).json({
      jobs,
      success: true,
      message: "Jobs fetched successfully.",
    });
  } catch (err) {
    return res.status(400).json({
      success: false,
      message: "Unable to fetch Jobs",
    });
  }
}
);


// jobs get by user id and accepted job applicants
router.get("/jobs/getUserIdAccepted/:id", auth.verifyUser, async (req, res) => {
  try {
    let jobs = await Job.find({$and:[{jobApplicants:req.params.id},{status:"Accepted"}]}).populate("jobApplicants");

    return res.status(200).json({
      jobs,
      success: true,
      message: "Jobs fetched successfully.",
    });
  } catch (err) {
    return res.status(400).json({
      success: false,
      message: "Unable to fetch Jobs",
    });
  }
}
);


// to get job by user id , status="Accepted" and job Applicants
router.get("/jobs/getUserIdStatus/:id", auth.verifyUser, async (req, res) => {
  try {
    let jobs = await Job.find({$and:[{userId:req.params.id},{status:"Accepted"},{ jobApplicants: { $exists: true, $not: {$size: 0} } }]}).populate("jobApplicants");

    return res.status(200).json({
      jobs,
      success: true,
      message: "Jobs fetched successfully.",
    });
  } catch (err) {
    return res.status(400).json({
      success: false,
      message: "Unable to fetch Jobs",
    });
  }
}
);






// To delete job by id
router.delete('/jobs/deleteById/:id', auth.verifyUser,  (req, res) => {

  try {
    Job.findByIdAndRemove(req.params.id).then((data) => {

      res.send({
        success: true,
        message: 'job successfully deleted',
        data: data
      });
    }
    )
  }
  catch (err) {
    res.status(400).json(err);
  }
}
);

// to delete all job by user id
router.delete('/jobs/deleteAllByUserId/:userId', auth.verifyUser,  (req, res) => {

  try {
    const userId = req.params.userId;
    Job.deleteMany({ userId }).then(jobs => {
      res.json(jobs);
    }
    );
  }
  catch (e) {
    res.status(400).json({ msg: e });
  }
}
);






module.exports = router;
