const express = require('express');
const app = express();

require('colors');
require('./config/database');
const cors = require("cors");


//Constants and routes
const userRoutes=require('./routes/UserRoutes');
const jobRoutes=require('./routes/jobRoutes');
const jobApplicantsRoutes=require('./routes/jobApplicantsRoutes');
const jobCategoryRoutes=require('./routes/jobCategoryRoutes');
const profileRoutes=require('./routes/profileRoutes');



//Before using any services enable CORS
app.use(cors());
app.options("*", cors()); // * means allow all the http request to pass from any other region

app.use(express.json(    ));
// app.use(express.static(__dirname + '/public'));  //this lines creates many issues while fetching images from the server

// code are able to fetch image from the file via server
app.use('/public',express.static(__dirname + '/public'));// so please use this code to fetch images form the server
app.use('/uploads', express.static('uploads'));

// Using api routes to connect to the routes
app.use(userRoutes);
app.use(jobRoutes);
app.use(jobApplicantsRoutes);
app.use(jobCategoryRoutes);
app.use(profileRoutes);

//Server
app.listen(5000, () => {
  console.log("Server running at http://localhost:5000".yellow.underline.bold);
});
