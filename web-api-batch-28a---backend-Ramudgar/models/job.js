const mongoose = require("mongoose");
const user=require('../models/Users');

let schema = new mongoose.Schema(
  {
    userId:{
      type: mongoose.Schema.Types.ObjectId,
      ref: "users",
    },
    
    title: {
      type: String,
      required: true,
    },
    maxApplicants: {
      type: Number,
    },
    maxPositions: {
      type: Number,
    },
    location: {
      type: String,
      required: true,
    },
    
    dateOfPosting: {
      type: String,
      default: Date.now,
    },
    deadline: {
      type: String,
      
    },
    skills: {
      type: String,   
    },
    jobType: {
      defalult: "PartTime",
      enum: ["FullTime", "PartTime", "Contract"],
      type: String,
      required: true,
    },
    duration: {
      type: String, 
    },
    salary: {
      type: String, 
    },
    description:{
      type: String,
    },
    image:{ type: String ,
      },
    status: {
      type: String,
      enum: ["Accepted", "Rejected","Pending"],
      default: "Pending",
    },
    jobApplicants:[{
        type: mongoose.Schema.Types.ObjectId,
        ref: "users",
      }],
      jobApplicantsCount: {
        type: String,
      },
      apply: {
       type:String,  }
  },
  { timestamps: true } 
);
module.exports = mongoose.model("jobs", schema);