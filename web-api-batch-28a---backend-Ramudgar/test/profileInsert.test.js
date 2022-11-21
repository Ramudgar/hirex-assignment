//using the path of User Model
const User = require('../models/Users');
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

describe('profile Schema test For inserting profile for both company and employee ', () => {
   //  Testing for inserting student 
     it('insert profile for both company and user', () => {
     const profile = {
    
     'name' : "Ramudgar",
     "skills":"java,python,nodejs",
     "phone":"123456789",
     
   
     };
     return Profile.create(profile)
     .then((pro_ret) => {
     expect(pro_ret.name).toEqual('Ramudgar');
     });
     });
      
    })