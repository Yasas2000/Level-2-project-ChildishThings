const express = require('express');
const router = express.Router();
const { sendEmail } = require('../models/sendEmail');
router.post('/', (req, res) => {
    const recipient = req.body.recipient;
    const message = req.body.message;
    sendEmail(recipient, message);
    res.status(200).send('Email sent successfully!');
  
    
  });

  module.exports=router;