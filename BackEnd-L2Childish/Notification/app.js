const express = require('express');
const db = require('./db');
const cors = require('cors');
const bodyParser=require('body-parser');
const deleteRoutes = require('./routes/deletes');
const donationRoutes=require('./routes/donations')
const feedbackRoutes=require('./routes/feedbacks');
const notificationRoutes=require('./routes/notifications');
const sendEmailRoutes=require('./routes/sendEmails');
const app = express();
const port = process.env.PORT || 3300;

app.use(bodyParser.json());
//app.use(express.json());
app.use(bodyParser.urlencoded({
    extended: true
  }));

app.use(cors({
origin: '*',
methods: ['get','post'],
allowedHeaders: ['Content-Type', 'Authorization'],
}));  

db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', () => {
  console.log('connected to database');
});

//app.use(express.json());

app.use('/delete', deleteRoutes);
app.use('/donation',donationRoutes);
app.use('/feed',feedbackRoutes);
app.use('/notification',notificationRoutes);
app.use('/send-email',sendEmailRoutes);

app.listen(port, () => {
  console.log(`server started at http://localhost:${port}`);
});
