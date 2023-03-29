const mongoose = require('mongoose');

// Define a schema for the data collection
const dataSchema = new mongoose.Schema({
    // title:String,
    // desc:String,
    // uid:String,
    // status:{type:Boolean,default:false},
    // readyBy:[{type:String}],
    // isCommon:{type:Boolean,default:false},
    // date:{type:Date,default:Date.now}
});

// Define a model for the data collection
const Data = mongoose.model('notifications', dataSchema);

module.exports = Data;
