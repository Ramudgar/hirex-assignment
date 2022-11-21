//using the path of User Model
const Job= require('../models/Job');
const mongoose =  require('mongoose');

// using abs_test as the test database
const url = "mongodb+srv://ramudgar:gnmN4rV3RxuuuKz6@cluster0.y6b9r.mongodb.net/HireX?retryWrites=true&w=majority";
beforeAll(async () => {
 await mongoose.connect(url, {
 useNewUrlParser: true,
//  useCreateIndex: true
 });
});
afterAll(async () => {
 await mongoose.connection.close();
});

describe('job Schema test For inserting ob for  employee ', () => {
   //  Testing for inserting student 
     it('insert job for user', () => {
     const job = {
    
     'title' : "flutter",
     "location":"ktm",
     "jobType":"FullTime",
     
   
     };
     return Job.create(job)
     .then((pro_ret) => {
     expect(pro_ret.title).toEqual('flutter');
     });
     });
      
    })