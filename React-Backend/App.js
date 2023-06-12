const express = require('express');
const app = express();
const notificationRouter = require('./route/notifications');
const donationRouter = require('./route/donations');
const helpRequestRouter = require('./route/helpRequest');
const registeredUserRouter = require('./route/registeredUsers');
const nonRegisteredUserRouter = require('./route/nonRegisteredUsers');
const quotationrequestRouter =require('./route/quotationrequest');
const eventRouter = require('./route/event');
const mongoose=require('mongoose');
const bodyParser = require('body-parser');
const cors=require('cors');

app.use(cors({
  origin:'*'
}));

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
  extended:true
}));

mongoose.connect("mongodb+srv://ekanayakaym20:2ilctvjCgYFhYP2W@cluster0.vyyy7ro.mongodb.net/Childish-Backend",{
  useNewUrlParser: true,  useUnifiedTopology: true });
// Mount the data router at the /api endpoint


app.use('/notifications',notificationRouter);
app.use('/donations',donationRouter);
app.use('/helprequest',helpRequestRouter);
app.use('/registeredUsers',registeredUserRouter);
app.use('/nonRegisteredUsers',nonRegisteredUserRouter);
app.use('/quotationrequest',quotationrequestRouter);
app.use('/event',eventRouter);

app.listen(5000, () => {
  console.log('Server started on port 5000');
});





