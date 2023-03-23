const double = require('@mongoosejs/double');
const mongoose = require('mongoose');

const Schema = mongoose.Schema;

let portraitSchema = new Schema({
    amount: {
        type: double
    },

    
   
})

module.exports = mongoose.model('portrait',portraitSchema);