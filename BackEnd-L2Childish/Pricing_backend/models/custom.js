const double = require('@mongoosejs/double');
const mongoose = require('mongoose');

const Schema = mongoose.Schema;

let CustomSchema = new Schema({
    amount: {
        type: double
    },
   
})

module.exports = mongoose.model('custom',CustomSchema);