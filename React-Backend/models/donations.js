const mongoose = require('mongoose');

// Define a schema for the data collection
const dataSchema = new mongoose.Schema({
    
});

// Define a model for the data collection
const Data = mongoose.model('donations', dataSchema);

module.exports = Data;