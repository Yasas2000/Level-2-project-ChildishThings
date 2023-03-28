const mongoose=require('mongoose');

const logsSchema = new mongoose.Schema(
    {
        id:String,
        pid:String,
        amount:Number,
        method:String,
        lname:String,
        fname:String,
        email:String,
  
    }
  );

const Donation =mongoose.model('donations',logsSchema);

module.exports =Donation;

