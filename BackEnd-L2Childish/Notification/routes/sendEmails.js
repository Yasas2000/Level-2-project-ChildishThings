const express = require('express');
const router = express.Router();
const { sendEmail } = require('../models/sendEmail');
router.post('/', (req, res) => {
    const subject='Payment Confirmation'; 
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
    sendEmail(recipient,subject, generateHTML(pid,amount,date));
    res.status(200).send('Email sent successfully!');
  
    
  });
  router.post('/quotation', (req, res) => {
    const subject='Portrait Quotation Request';
    const recipient='ymeka2000@gmail.com';
    const numBigFamilies = req.body.numBigFamilies;
    const name= req.body.firstName+req.body.lastName;
    const number= req.body.contactNumber;
    const email=req.body.email;
    const date= req.body.date;
    const eventDurationHours= req.body.eventDurationHours;
    const eventLocation=req.body.eventLocation;
    const eventStarttime=req.body.eventStarttime;
    const totInvitees=req.body.totInvitees;
    const numSmallFamilies=req.body.numSmallFamilies;
    const numMarriedCouples=req.body.numMarriedCouples;
    const numUnMarriedCouples=req.body.numUnMarriedCouples;
    const numIndividualInvitees=req.body.numIndividualInvitees;
    const logoPath = "https://images.squarespace-cdn.com/content/v1/5f633f2a3ceb25330f960d39/9370e95a-b4f8-4ddf-952e-cbd33a7157cd/Photobooth.png?format=1500w"; // Replace with the actual path to your logo image

// Function to generate the HTML with dynamic parameters
function generateHTML
 (name,
  number,
  email,
  date,
  numBigFamilies,
  numSmallFamilies,
  numMarriedCouples,
  numUnMarriedCouples,
  numIndividualInvitees,
  eventLocation,
  eventDurationHours,
  eventStarttime,
  totInvitees) {
  return `
  <!DOCTYPE html>
  <html>
  <head>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
      }
  
      .container {
        width: 800px;
        margin: 0 auto;
        padding: 20px;
        background-color: #f88440;
        color: #f8ffd0;
      }
  
      .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
      }
  
      .header img {
        max-height: 80px;
      }
  
      .logo-section {
        text-align: center;
        width:800px
        background-color: #f7f7f7;
      }
        .logo-section img {
        max-height: 100px;
        max-width: 200px;
        color:#000000;
      }
  
      .customer-details,
      .company-details {
        width: 48%;
      }
  
      .customer-details h2,
      .company-details h2 {
        font-size: 20px;
        margin-top: 0;
        margin-bottom: 10px;
      }
  
      .customer-details p,
      .company-details p {
        margin-top: 0;
        margin-bottom: 5px;
      }
  
      table {
        width: 100%;
        border-collapse: collapse;
      }
  
      th, td {
        padding: 10px;
        text-align: left;
      }
  
      th {
        background-color: #ff9e7c;
        font-weight: bold;
      }
  
      .total {
        font-weight: bold;
        text-align: right;
        background-color: #000000;
      }
    </style>
  </head>
  <body>
    <div class="logo-section">
        <img src="https://images.squarespace-cdn.com/content/v1/5f633f2a3ceb25330f960d39/9370e95a-b4f8-4ddf-952e-cbd33a7157cd/Photobooth.png?format=1500w" alt="Company Logo">
      </div>
    <div class="container">
      <div class="header">
        <div class="customer-details">
          <h2>Customer Details</h2>
          <p>${name}</p>
          <p>${email}</p>
          <p>${eventLocation}</p>
          <p>${number}</p>
          <p>${date}</p>
          <p>Event time ${eventStarttime}</p>

        </div>
        <div class="company-details">
          <h2>Company Details</h2>
          <p>PhotoBoothMe LK</p>
          <p>456 Business Avenue</p>
          <p>City, State, ZIP</p>
          <p>Tel:0788127829<p>
        </div>
      </div>
      
      <div class="quotation-details">
        <h2>Quotation</h2>
        <table>
          <tr>
            <th>Item</th>
            <th>Options</th>
            <th>Quantity</th>
          </tr>
          <tr>
            <td>Portrait</td>
            <td>No of big families</td>
            <td>${numBigFamilies}</td>
          </tr>
          <tr>
            <td></td>
            <td>No of small families</td>
            <td>${numSmallFamilies}</td>
          </tr>
          <tr>
            <td></td>
            <td>No of Married Couples</td>
            <td>${numMarriedCouples}</td>
          </tr>
          <tr>
            <td></td>
            <td>No of Unmarried Couples</td>
            <td>${numUnMarriedCouples}</td>
          </tr>
          <tr>
            <td></td>
            <td>No of Individuals</td>
            <td>${numIndividualInvitees}</td>
          </tr>
          <tr>
            <td></td>
            <td>Total Invitees</td>
            <td>${totInvitees}</td>
          </tr>
          <!-- Add more rows for additional items -->
          <tr class="total">
            <td colspan="2">Total:</td>
            <td>$100</td>
          </tr>
        </table>
      </div>
    </div>
  </body>
  </html>
  `;
}
    sendEmail(recipient,subject, generateHTML(name,
      number,
      email,
      date,
      numBigFamilies,
      numSmallFamilies,
      numMarriedCouples,
      numUnMarriedCouples,
      numIndividualInvitees,
      eventLocation,
      eventDurationHours,
      eventStarttime,
      totInvitees));
    res.status(200).send('Email sent successfully!');
  
    
  });
  router.post('/quotationStripes', (req, res) => {
    const subject='Stripes Quotation Request';
    const recipient='ymeka2000@gmail.com';
    const name= req.body.firstName+req.body.lastName;
    const number= req.body.contactNumber;
    const email=req.body.email;
    const date= req.body.date;
    const eventDurationHours= req.body.eventDurationHours;
    const eventLocation=req.body.eventLocation;
    const eventStarttime=req.body.eventStarttime;
    const totInvitees=req.body.totInvitees;
    const logoPath = "https://images.squarespace-cdn.com/content/v1/5f633f2a3ceb25330f960d39/9370e95a-b4f8-4ddf-952e-cbd33a7157cd/Photobooth.png?format=1500w"; // Replace with the actual path to your logo image

// Function to generate the HTML with dynamic parameters
function generateHTML
 (name,
  number,
  email,
  date,
  eventLocation,
  eventDurationHours,
  eventStarttime,
  totInvitees) {
  return `
  <html>
  <head>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
      }
  
      .container {
        width: 800px;
        margin: 0 auto;
        padding: 20px;
        background-color: #f88440;
        color: #f8ffd0;
      }
  
      .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
      }
  
      .header img {
        max-height: 80px;
      }
  
      .logo-section {
        text-align: center;
        width:800px
        background-color: #f7f7f7;
      }
        .logo-section img {
        max-height: 100px;
        max-width: 200px;
        align:center;
        color:#000000;
      }
  
      .customer-details,
      .company-details {
        width: 48%;
      }
  
      .customer-details h2,
      .company-details h2 {
        font-size: 20px;
        margin-top: 0;
        margin-bottom: 10px;
      }
  
      .customer-details p,
      .company-details p {
        margin-top: 0;
        margin-bottom: 5px;
      }
  
      table {
        width: 100%;
        border-collapse: collapse;
      }
  
      th, td {
        padding: 10px;
        text-align: left;
      }
  
      th {
        background-color: #ff9e7c;
        font-weight: bold;
      }
  
      .total {
        font-weight: bold;
        text-align: right;
        background-color: #000000;
      }
    </style>
  </head>
  <body>
    <div class="logo-section">
        <img src="https://images.squarespace-cdn.com/content/v1/5f633f2a3ceb25330f960d39/9370e95a-b4f8-4ddf-952e-cbd33a7157cd/Photobooth.png?format=1500w" alt="Company Logo">
      </div>
    <div class="container">
      <div class="header">
        <div class="customer-details">
          <h2>Customer Details</h2>
          <p>${name}</p>
          <p>${email}</p>
          <p>${eventLocation}</p>
          <p>${number}</p>
          <p>${date}</p>
          <p>Event time ${eventStarttime}</p>

        </div>
        <div class="company-details">
          <h2>Company Details</h2>
          <p>PhotoBoothMe LK</p>
          <p>456 Business Avenue</p>
          <p>City, State, ZIP</p>
          <p>Tel:0788127829<p>
        </div>
      </div>
      
      <div class="quotation-details">
        <h2>Quotation</h2>
        <table>
          <tr>
            <th>Item</th>
            <th>Options</th>
            <th>Quantity</th>
          </tr>

          <tr>
            <td>Stripes</td>
            <td>Total Invitees</td>
            <td>${totInvitees}</td>
          </tr>
          <tr>
          <td></td>
          <td>Duration</td>
          <td>${eventDurationHours} hrs</td>
          </tr>
          <!-- Add more rows for additional items -->
          <tr class="total">
            <td colspan="2">Total:</td>
            <td>$100</td>
          </tr>
        </table>
      </div>
    </div>
  </body>
  </html>
  `;
}
    sendEmail(recipient,subject, generateHTML(name,
      number,
      email,
      date,
      eventLocation,
      eventDurationHours,
      eventStarttime,
      totInvitees));
    res.status(200).send('Email sent successfully!');
  
    
  });
  module.exports=router;