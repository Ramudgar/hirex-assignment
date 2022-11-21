//using the path of User Model
const Job = require('../models/job');
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

describe('getting job', () => {
   
     it('to test the get job is working or not', async () => {
    const status = await Job.find();
    expect(status.ok);
   });
    })