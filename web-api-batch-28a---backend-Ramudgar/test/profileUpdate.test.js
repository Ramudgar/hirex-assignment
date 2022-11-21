//using the path of User Model
const Profile= require('../models/Profile');
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

describe('profile Schema test For updating', () => {


     //Test for updating student 
     it('Test for profile update', async () => {
        return Profile.findOneAndUpdate({_id :Object('62de88fba090852469584e4c')}, 
       {$set : {name:'test pass'}})
        .then((pp)=>{
        expect(pp.name).toEqual('test pass')
        })
        
       });
    })