

const mongoose=require('mongoose');


// const DB = "mongodb+srv://ramudgar:gnmN4rV3RxuuuKz6@cluster0.y6b9r.mongodb.net/HireX?retryWrites=true&w=majority";
const DB="mongodb://localhost:27017/HireX";

try {
    mongoose.connect(DB,{
        useNewUrlParser:true,
        useUnifiedTopology:true,
    });
} catch (error) {
    console.log(error);
    
}



