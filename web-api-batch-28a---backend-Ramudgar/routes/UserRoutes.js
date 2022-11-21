const express = require('express');
const router = express.Router();
const auth = require('../auth/auth')
const bcryptjs = require('bcryptjs')
const jwt = require('jsonwebtoken');
const User=require('../models/Users');

router.post('/user/register', (req, res) => {

    const email = req.body.email;
    const role = req.body.role;
    try{ User.findOne({ email: email, role: role })
    .then((user_data) => {
        if (user_data != null) {
            res.status(400).json({ msg: 'email already exists with the same role',success:false });
            return;
        }
        else{
          const email = req.body.email;
        const username = req.body.username;
        const password = req.body.password;
        const role = req.body.role;

        bcryptjs.hash(password, 10, (e, hashed_pw) => {

            const data = new User({
                email: email,
                username: username,
                password: hashed_pw,
                role: role,
            });
            data.save().then((data) => {
                res.json({ msg: 'Data inserted', success: true ,data});
            });
        })
        }   })} catch(e){
        res.status(500).json({msg:e,success:false});
    }
   
});




// For Login
router.post('/user/login', (req, res) => {
    const email = req.body.email;
    const password = req.body.password;
    const role = req.body.role;

    try{
        User.findOne({ email: email, role: role })
        .then((user_data) => {
            if (user_data == null) {
                res.status(400).json({ msg: 'User does not exist' });
                return;
            }
            bcryptjs.compare(password, user_data.password, (e, result) => {
                if (result) {
                    const token = jwt.sign({ _id: user_data._id }, 'softwarica', { expiresIn: '1d' });
                    res.status(200).json({ token: token, user: user_data,success:true });
                } else {
                    res.status(400).json({ msg: 'invalid credentials' });
                }
            }
            )

        })
    }catch(e){
        res.json({ msg: e });
    }
}
);


// router.post("/find-email", function (req, res) {
//     const email = req.body.email;
//     User.findOne({ email: email })
//       .then(function (data) {
//         if (data == null) {
//           return res
//             .status(403)
//             .json({ success: false, message: "User not found" });
//         }
//         res.status(203).json({ success: true, message: "User found!" });
//       })
//       .catch(function (e) {
//         res.status(403).json({ message: e });
//       });
//   });
//   router.post("/forgot-password", (req, res) => {
//     User.findOne({ email: req.body.email }).then((user) => {
//       if (!user) {
//         res.status(422).json({ message: "User does not exist!" });
//       }
//       // const otpCode = Math.floor(Math.random() * 10000 + 1);
//       const otpCode = 8492;
//       const otpData = new otp({
//         email: req.body.email,
//         code: otpCode,
//       });
//       otpData
//         .save()
//         .then(function () {
//           // var transporter = nodeMailer.createTransport({
//           //   service: "gmail",
//           //   auth: {
//           //     user: "codeebugs@gmail.com",
//           //     pass: "CodeeBugs123",
//           //   },
//           // });
//           // var mailOptions = {
//           //   from: "codeebugs@gmail.com",
//           //   to: req.body.email,
//           //   subject: "OTP Code",
//           //   html: `
//           //             <h4>You have requested to reset your password.</h5>
//           //             <p>Your OTP code is ${otpCode}.</p>
//           //             <p>This code will expire in 1 hour.</p>
//           //             `,
//           // };
//           // transporter.sendMail(mailOptions, function (error, info) {
//           //   if (error) {
//           //     console.log(error);
//           //   } else {
//           //     console.log("email sent");
//           //     res.status(201).json({ message: "Check e-mail!" });
//           //   }
//           // });
//         })
//         .catch(function (e) {
//           res.status().json({ message: e });
//         });
//     });
//   });


// //smtp
// router.put("/reset-password", (req, res) => {
//     // const otpCode = req.body.otp;
//     const otpCode = 8492;
//     otp.findOne({ code: otpCode }).then(function (data) {
//       if (data == null) {
//         res.status(403).json({ message: "Invalid Code!" });
//       } else if (data.expireTime - Date.now() < 0) {
//         res.status(403).json({ message: "OTP has expired!:" });
//       } else {
//         const newPassword = req.body.newPassword;
//         bcryptjs.hash(newPassword, 12, function (err, hash12) {
//           User.updateOne({ email: data.email }, { password: hash12 })
//             .then(function (result) {
//               res.status(203).json({ message: "Password succesfully changed!" });
//             })
//             .catch(function (e) {
//               res.status(401).json({ message: e });
//             });
//         });
//         // otp
//         //   .findOneAndDelete({ email: data.email })
//         //   .then(function (result) {
//         //     res.status(203).json({ message: "Otp deleted!" });
//         //   })
//         //   .catch(function (e) {
//         //     res.status(401).json({ message: e });
//         //   });
//       }
//     });
//   });



//   //password change
// router.put("/changepassword", function (req, res) {
//   const userID = req.userData._id;
//   const oldPassword = req.body.oldPassword;
//   const newPassword = req.body.newPassword;
//   User.findOne({ _id: userID }).then(function (data) {
//     bcryptjs.compare(oldPassword, data.password, function (err, result) {
//       if (result) {
//         bcryptjs.hash(newPassword, 12, function (err, hash12) {
//           var password = { newPassword: hash12 };
//           User.updateOne({ _id: userID }, { password: hash12 })
//             .then(function (result) {
//               if (result) {
//                 res
//                   .status(201)
//                   .json({ success: true, message: "Password changed!" });
//               }
//             })
//             .catch(function (e) {
//               res.status(403).json({ message: e });
//             });
//         });
//       } else {
//         res.status(401).json({ message: "Invalid Password!" });
//       }
//     });
//   });
// });


module.exports=router;
    