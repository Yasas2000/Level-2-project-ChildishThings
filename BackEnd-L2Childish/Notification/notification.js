const express = require('express');
const { Int32, Decimal128, ObjectId } = require('mongodb');
const bodyParser=require('body-parser');
const mongoose = require('mongoose');
const app = express();
const cors = require('cors');
app.use(cors({
  origin: 'http://localhost:3240',
  methods: ['get','post'],
  allowedHeaders: ['Content-Type', 'Authorization'],
}));
app.use(bodyParser.json());
//app.use(express.json());
app.use(bodyParser.urlencoded({
    extended: true
  }));

mongoose.connect('mongodb://localhost:27017/form', {useNewUrlParser: true,
useUnifiedTopology:true});

const notificationSchema = new mongoose.Schema({
  uid: String,
  
});
const commonnotSchema=new mongoose.Schema({
  uid:String
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
const Common=mongoose.model('commonnots',commonnotSchema);
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
app.get('/commonnots/:userId', (req, res) => {
  Common.find({uid: req.params.userId }, (err, commons) => {
    if (err) {
      res.status(500).send(err);
    } else {
      res.send(commons);
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
  Notification.find({uid: req.params.userId }, (err, notifications) => {
    if (err) {
      res.status(500).send(err);
    } else {
      res.send(notifications);
    }
  });
});

app.listen(3000, () => {
  console.log('Server started on port 3000');
});