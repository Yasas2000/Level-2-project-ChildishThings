const nodemailer = require('nodemailer');
let transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: 'photoboothme499@gmail.com',
      pass: 'vnkwowpzrxrnbnwk'
    }
  });
  function sendEmail(recipient,html){

    const mailOptions = {
        from: 'photoboothme499@gmail.com',
        to: recipient,
        subject: 'Payment Confirmation',
        html:html,
      };
    
      transporter.sendMail(mailOptions, function(error, info) {
        if (error) {
          console.log(error);
          res.status(500).send('Error: Could not send email');
        } else {
          console.log('Email sent: ' + info.response);
          
        }
      });
  }
  module.exports = {
    sendEmail
  };  