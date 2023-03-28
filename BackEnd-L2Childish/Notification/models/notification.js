const mongoose=require('mongoose');

const notificationSchema = new mongoose.Schema({
    title: String,
    desc: String,
    uid: String,
    status:{type:Boolean,default:false},
    readBy: [{type:String}],
    isCommon:{type:Boolean,default:false},
    date: { type: Date, default: Date.now },
    
  });

const Notification = mongoose.model('notifications', notificationSchema);

module.exports=Notification;