const express = require('express');
const { Int32, Decimal128, ObjectId, Double } = require('mongodb');
const bodyParser=require('body-parser');
const mongoose = require('mongoose');
const app = express();
const cors = require('cors');
const { sendEmail } = require('./sendEmail');
app.use(bodyParser.json());
//app.use(express.json());
app.use(bodyParser.urlencoded({
    extended: true
  }));

app.post('/send-email', (req, res) => {
  const recipient = req.body.recipient;
  const message = req.body.message;
  sendEmail(recipient, message);
  res.status(200).send('Email sent successfully!');

  
});
app.use(cors({
  origin: '*',
  methods: ['get','post'],
  allowedHeaders: ['Content-Type', 'Authorization'],
}));


mongoose.connect('mongodb+srv://ekanayakaym20:2ilctvjCgYFhYP2W@cluster0.vyyy7ro.mongodb.net/Childish-Backend', {
useNewUrlParser: true,
useUnifiedTopology:true
});

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
const User =mongoose.model('donations',logsSchema);
app.get('/leaderboard',(req,res)=>{
  console.log(User);
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
  title: String,
  desc: String,
  uid: String,
  status:{type:Boolean,default:false},
  readBy: [{type:String}],
  isCommon:{type:Boolean,default:false},
  date: { type: Date, default: Date.now },
  
});
const deletedNotsSchema=new mongoose.Schema({
  uid:String,
  oid:String
});
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
app.post('/pushNotifications',(req,res)=>{
  console.log(req.body);
  const not=req.body;
  const notification=new Notification(not);
  notification.save((err)=>{
    if(err){
      console.log('Error');
      res.status(500).send(err);
  } else{
      console.log('success');
      res.send('Form submitted successfully');
  }
  });

});
app.put('/read/:notificationId,:userId', async (req, res) => {
  const notificationId = req.params.notificationId;
  const userId = req.params.userId;
  try {
    const notification = await Notification.findById(notificationId);

    // if (!notification) {
    //   return res.status(404).send('Notification not found');
    // }

    // if (notification.uid !== null && notification.uid !== userId) {
    //   return res.status(403).send('Not authorized to mark this notification as read');
    // }

  if(notification.uid=='null'){
    console.log('up1');
    await Notification.updateOne(
      { _id: notificationId },
      { $addToSet: { readBy: userId } },
      { new: true }
    );

  }
  else{
    console.log('up2');
    await Notification.updateOne(
      { _id: notificationId ,uid:userId,status:false},
      { $set: { status:true } },
      
    );
  }
 //await notification.save();
}catch(err){
  console.error(err);
    res.status(500).send('Internal server error');
}

  
});
app.get('/notifications/:userId', (req, res) => {
  const userId=req.params.userId;
  Notification.find({$or: [{uid:userId}, {uid:"null"}]}).sort({date:-1})
  .exec((err,notifications)=>{
     if(err){
      res.status(500).send(err);
     }else{
      res.send(notifications);
     }
  });
});
app.get('/count/:id', (req, res) => {
  // Use connect method to connect to the server
  const id =req.params.id;
 

      // Get the Notifications and Deletions models


      // Define the query for the Notifications collection
      const notificationsQuery = Notification.aggregate([
        { $match: { 

          $and: [
            { $or: [{ uid:id }, { uid: 'null' }] },
            { status: false },
            { readBy: { $ne: id } }
          ]
         } },
        { $count: "notificationsCount" }
      ]);

      // Execute the query on the Notifications collection
      notificationsQuery.exec((err, notificationsResult) => {
        if (err) throw err;

        // Define the query for the Deletions collection
        const deletionsQuery = DeletedNots.countDocuments({ uid: id });

        // Execute the query on the Deletions collection
        deletionsQuery.exec((err, deletionsCount) => {
          if (err) throw err;
          console.log(notificationsResult)
          if (notificationsResult && notificationsResult.length > 0) {
            const totalNotifications = notificationsResult[0].notificationsCount;
            res.json({ count: totalNotifications });
          } else {
            res.json({ count: 0 });
          }

        });
      });
    
    
});

app.listen(3300, () => {
  console.log('Server started on port 3300');
});
