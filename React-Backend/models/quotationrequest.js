const mongoose = require('mongoose');

// Define a schema for the data collection
const dataSchema = new mongoose.Schema({
    
});

// Define a model for the data collection
const Data = mongoose.model('group1', dataSchema);

module.exports = Data;