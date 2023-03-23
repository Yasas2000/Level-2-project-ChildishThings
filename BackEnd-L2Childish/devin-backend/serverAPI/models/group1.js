const mongoose = require('mongoose');
const Schema = mongoose.Schema;

let groupSchema = new Schema({
    firstName: {
        type: String
    },
    lastName: {
        type: String
    },
    contactNumber: {
        type: String
    },
    email: {
        type: String
    },
    eventStarttime: {
        type: String
    },
    date: {
        type: String
    },
    eventDurationHours: {
        type: Number
    },
    eventLocation:{
        type: String 
    },
    totInvitees: {
        type: Number
    },
    remarks: {
        type: String
    }

    
})

module.exports = mongoose.model('group1',groupSchema);