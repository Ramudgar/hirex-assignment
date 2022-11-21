//using the path of User Model
const Profile = require('../models/Profile');
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

describe('getting profile', () => {
   
     it('to test the get profile is working or not', async () => {
    const status = await Profile.find();
    expect(status.ok);
   });
    })