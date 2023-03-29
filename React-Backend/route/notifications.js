const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');
const Notifications = require('../models/notifications'); // Import the data model

// Define a GET route to retrieve all data
router.get('/', async (req, res) => {
  console.log(Notifications)
  try {
    const notifications = await Notifications.find(); // Retrieve all data from MongoDB
    res.json(notifications); // Send the data as a JSON response
  } catch (err) {
    console.error(err);
    res.status(500).send('Server error');
  }
});


module.exports = router;
