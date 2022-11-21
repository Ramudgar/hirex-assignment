
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const UserSchema = new Schema({
  email: {
    type: String,
    required: true,
    trim: true
  },
  password: {
    type: String,
    required: true
  },
  role: {
    type: String,
    enum: ["company", "investor", "employee"],
    required: true
  },
  username: {
    type: String,
    //  required: true,
  },
  accessToken: {
    type: String
  },
  code: { type: String },
  

});
// UserSchema.index({ "expire_at": 1 }, { expireAfterSeconds: 3600 });

const User = mongoose.model('users', UserSchema);

module.exports = User;