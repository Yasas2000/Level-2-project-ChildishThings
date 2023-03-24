const express = require('express');
const { Int32, Decimal128, ObjectId } = require('mongodb');
const bodyParser=require('body-parser');
const mongoose = require('mongoose');
const app = express();
const cors = require('cors');
app.use(cors({
  origin: '*',
  methods: ['get','post'],
  allowedHeaders: ['Content-Type', 'Authorization'],
}));
app.use(bodyParser.json());
//app.use(express.json());
app.use(bodyParser.urlencoded({
    extended: true
  }));

mongoose.connect('mongodb+srv://ekanayakaym20:2ilctvjCgYFhYP2W@cluster0.vyyy7ro.mongodb.net/Childish-Backend', {useNewUrlParser: true,
useUnifiedTopology:true});

const logsSchema = new mongoose.Schema(
  {
      id:String,
      pid:String,
      amount:String,
      method:String,
      lname:String,
      fname:String,
      email:String,

  }
);
const User =mongoose.model('Donations',logsSchema);
app.get('/leaderboard',(req,res)=>{
  User.aggregate([
    {
     $match:{
      id:{$ne:"null"}
     }
    } , 
    {
          $group:{
              _id:"$id",
              totalAmount:{$sum:"$amount"},
          }
      },
      {
        $project: {
          _id: 1,
          totalAmount: 1,
          points:{$trunc: { $divide: ["$totalAmount", 1000] }}
        }
      },
      {
        $sort:{
          totalAmount:-1
        }
      }
  ]).exec((err,result)=>{
      if(err){
          console.log(err);
          res.status(500).send('An error occurred');
      }else{
          res.send(result);
      }
  });
});

app.post('/submit',(req,res)=>
{
  console.log(req.body);
  // const userdata=req.body;
  // const user=new User(userdata);
  const user= new User({
      id:req.body.id,
      pid:req.body.pid,
      amount:req.body.amount,
      method:req.body.method,
      lname:req.body.lname,
      fname:req.body.fname,
      email:req.body.email,
      
  });

  user.save((err)=>
{
  if(err){
      console.log('Error');
      res.status(500).send(err);
  } else{
      console.log('success');
      res.send('Form submitted successfully');
  }
});

});

const notificationSchema = new mongoose.Schema({
  uid: String,
  
});
const deletedNotsSchema=new mongoose.Schema({
  uid:String,
  oid:String
})
const feedbackSchema=new mongoose.Schema(
  {
   uid:String,
   rating:Decimal128,
   comment:String,
   dt:Date
  }
);
const DeletedNots=mongoose.model('deletednots',deletedNotsSchema); 
app.post('/delete',(req,res)=>{
  const deletednots=new DeletedNots({
    uid:req.body.uid,
    oid:req.body.oid
  });
  deletednots.save((err)=>
  {
    if(err){
      console.log('Error');
      res.status(500).send(err);
  } else{
      console.log('success');
      res.send('Deleted Success');
  }
  });
});
app.get('/deletes/:userId', (req, res) => {
  DeletedNots.find({uid: req.params.userId }, (err, deletions) => {
    if (err) {
      res.status(500).send(err);
    } else {
      res.send(deletions);
    }
  });
});

const Feedback=mongoose.model('feedbacks',feedbackSchema);
app.post('/feed',(req,res)=>
{
    console.log(req.body);
    const feedback=new Feedback({
      uid:req.body.uid,
      rating:req.body.rating,
      comment:req.body.comment,
      dt:req.body.dtS
    });

    feedback.save((err)=>
{
    if(err){
        console.log('Error');
        res.status(500).send(err);
    } else{
        console.log('success');
        res.send('Feedback submitted successfully');
    }
});

});

const Notification = mongoose.model('notifications', notificationSchema);


app.get('/delete-notification/:oid', function(req, res) {
  const oid=req.params.oid; 

  Notification.findByIdAndDelete(oid, function(err, notification) {
    if (err) {
      console.log(err);
      res.status(500).send(err);
      return;
    }
    
    if (notification) {
      res.send('Notification deleted successfully');
    } else {
      res.status(404).send('Notification not found');
    }
  });
});


app.get('/notifications/:userId', (req, res) => {
  const userId=req.params.userId;
  Notification.find({$or: [{uid:userId}, {uid:"null"}]}, (err, notifications) => {
    if (err) {
      res.status(500).send(err);
    } else {
      res.send(notifications);
    }
  });
});

app.listen(3300, () => {
  console.log('Server started on port 3300');
});
