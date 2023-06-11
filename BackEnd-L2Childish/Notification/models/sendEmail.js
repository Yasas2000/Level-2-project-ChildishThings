const nodemailer = require('nodemailer');
const inlineCss = require('inline-css');
let transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: 'photoboothme499@gmail.com',
      pass: 'vnkwowpzrxrnbnwk'
    }
  });
  function sendEmail(recipient,subject,html){
    inlineCss(html, { url: ' ' }) // Pass an empty URL to prevent loading external resources
  .then((inlinedHtml) => {
    const mailOptions = {
        from: 'photoboothme499@gmail.com',
        to: recipient,
        subject: subject,
        html:inlinedHtml,
      };
    
      transporter.sendMail(mailOptions, function(error, info) {
        if (error) {
          console.log(error);
          res.status(500).send('Error: Could not send email');
        } else {
          console.log('Email sent: ' + info.response);
          
        }
      });
    });
  }
  module.exports = {
    sendEmail
  };  