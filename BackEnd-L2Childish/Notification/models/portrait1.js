const double = require('@mongoosejs/double');
const mongoose = require('mongoose');

const Schema = mongoose.Schema;

let portraitSchema1 = new Schema({
    
    amount1: {
        type: double
    },
   
})

module.exports = mongoose.model('portrait1',portraitSchema1);