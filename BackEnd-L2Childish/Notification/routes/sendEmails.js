const express = require('express');
const router = express.Router();
const { sendEmail } = require('../models/sendEmail');
router.post('/', (req, res) => {
    const recipient = req.body.recipient;
    const pid = req.body.pid;
    const amount = req.body.amount;
    const date = req.body.date;
    const logoPath = "https://images.squarespace-cdn.com/content/v1/5f633f2a3ceb25330f960d39/9370e95a-b4f8-4ddf-952e-cbd33a7157cd/Photobooth.png?format=1500w"; // Replace with the actual path to your logo image

// Function to generate the HTML with dynamic parameters
function generateHTML(paymentId, amount, date) {
  return `
    <html>
      <head>
        <style>
          /* Define your CSS styles here */
          .container {
            max-width: 600px;
            margin: 0 auto;
          }
          .header {
            background-color: #f5f5f5;
            padding: 20px;
          }
          .content {
            padding: 20px;
          }
          .footer {
            background-color: #f5f5f5;
            padding: 20px;
            text-align: center;
          }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="header">
            <img src=${logoPath} alt="Company Logo" width="200" height="auto">
            <h1>Payment Confirmation</h1>
          </div>
          <div class="content">
            <p>Dear recipient,</p>
            <p>We are pleased to inform you that your payment has been successfully processed.</p>
            <p>Payment details:</p>
            <ul>
              <li>Payment ID: ${paymentId}</li>
              <li>Amount: $${amount}</li>
              <li>Date: ${date}</li>
            </ul>
            <p>Please find attached the payment receipt.</p>
          </div>
          <div class="footer">
            <p>Thank you for your business.</p>
          </div>
        </div>
      </body>
    </html>
  `;
}
    sendEmail(recipient, generateHTML(pid,amount,date));
    res.status(200).send('Email sent successfully!');
  
    
  });

  module.exports=router;