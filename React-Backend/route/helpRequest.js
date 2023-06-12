const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');
const edu_help_requests = require('../models/helprequest');

// Define a GET route to retrieve all data
router.get('/', async (req, res) => {
  try {
    const helprequest = await edu_help_requests.find(); // Retrieve all data from MongoDB
    res.json(helprequest); // Send the data as a JSON response
  } catch (err) {
    console.error(err);
    res.status(500).send('Server error');
  }
});

module.exports = router;