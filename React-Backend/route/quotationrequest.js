const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');
const QuotationRequest = require('../models/quotationrequest'); // Import the data model

// Define a GET route to retrieve all data
router.get('/', async (req, res) => {
  try {
    const quotationRequest = await eduHelp.find(); // Retrieve all data from MongoDB
    res.json(quotationRequest); // Send the data as a JSON response
  } catch (err) {
    console.error(err);
    res.status(500).send('Server error');
  }
});

module.exports = router;