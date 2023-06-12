const mongoose = require('mongoose');
const Schema = mongoose.Schema;

let groupSchema = new Schema({
    numBigFamilies: {
        type: Number
    },
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
    numSmallFamilies: {
        type: Number
    },
    numMarriedCouples: {
        type: Number
    },
    numUnMarriedCouples: {
        type: Number
    },
    numIndividualInvitees: {
        type: Number
    },
    remarks: {
        type: String
    }

    
})

module.exports = mongoose.model('groups',groupSchema);
