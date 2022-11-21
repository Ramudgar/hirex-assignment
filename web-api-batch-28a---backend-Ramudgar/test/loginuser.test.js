//using the path of User Model
const User = require('../models/Users');
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

describe('User Schema test For inserting', () => {
   //  Testing for inserting student 
     it('Add User testing inserting', () => {
     const user = {
    
     'email' : "test@gmail.com",
     
   'role': "company",
     'password': 'test',
     'username': 'test'
     };
     return User.create(user)
     .then((pro_ret) => {
     expect(pro_ret.email).toEqual('test@gmail.com');
     });
     });

    
      
    })