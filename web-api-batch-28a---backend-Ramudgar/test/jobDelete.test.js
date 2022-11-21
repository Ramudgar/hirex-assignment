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

describe('Job schema test For deleting', () => {
   
    it('to test the delete job is working or not', async () => {
        const status = await Profile.deleteOne({_id :Object('62dc42bf0db7d854a8a1a11b')});
        expect(status.ok);
       });
    })