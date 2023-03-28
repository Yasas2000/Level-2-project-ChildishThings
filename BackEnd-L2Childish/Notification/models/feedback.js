const mongoose=require('mongoose');
const { Int32, Decimal128, ObjectId, Double } = require('mongodb');

const feedbackSchema=new mongoose.Schema(
    {
     uid:String,
     rating:Decimal128,
     comment:String,
     dt:Date
    }
  );

const Feedback=mongoose.model('feedbacks',feedbackSchema);  

module.exports=Feedback;