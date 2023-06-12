const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');
const Event = require('../models/event'); // Import the data model

// Define a GET route to retrieve all data
router.get('/', async (req, res) => {
  try {
    const event = await Event.find(); // Retrieve all data from MongoDB
    res.json(event); // Send the data as a JSON response
  } catch (err) {
    console.error(err);
    res.status(500).send('Server error');
  }
});

module.exports = router;