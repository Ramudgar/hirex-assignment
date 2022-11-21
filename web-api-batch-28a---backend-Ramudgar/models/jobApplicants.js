const mongoose = require("mongoose");

let schema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "users",
      required: true
    },
    job: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "jobs",
      required: true
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("JobApplicants", schema);