const express = require('express');
const router = express.Router();
const DeletedNots=require('../models/delete')
const Notification = require('../models/notification');

router.get('/delete-notification/:oid', function(req, res) {
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
router.post('/pushNotifications',(req,res)=>{
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
  router.put('/read/:notificationId,:userId', async (req, res) => {
    const notificationId = req.params.notificationId;
    const userId = req.params.userId;
    try {
      const notification = await Notification.findById(notificationId);
  
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
  router.get('/viewnotifications/:userId', (req, res) => {
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
  router.get('/count/:id', (req, res) => {
    const id =req.params.id;
        // Get the Notifications and Deletions models
        // Define the query for the Notifications collection
        const notificationsQuery = Notification.aggregate([
          { $match: { 
  
            $and: [
              { $or: [{ uid:id }, { uid: 'null' }] },
              { status: false },
              { readBy: { $ne: id } } //create readby array in documeny to identify viewed users of common notifications
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

  module.exports=router;