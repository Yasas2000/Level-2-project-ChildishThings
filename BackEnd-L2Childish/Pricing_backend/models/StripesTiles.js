const mongoose = require('mongoose');

const Schema = mongoose.Schema;

let StripesSchema = new Schema({
    imageAsset: {
        type: String
    },
    text: {
        type: String
    },
    amount: {
        type: String
    },
    hour: {
        type: String    
    },
})

module.exports = mongoose.model('StripesTiles',StripesSchema);