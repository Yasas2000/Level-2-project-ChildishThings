const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');
const Donations = require('../models/donations'); // Import the data model

// Define a GET route to retrieve all data
router.get('/', async (req, res) => {
  console.log(Donations)
  try {
    const donations = await Donations.find(); // Retrieve all data from MongoDB
    res.json(donations); // Send the data as a JSON response
  } catch (err) {
    console.error(err);
    res.status(500).send('Server error');
  }
});

module.exports = router;