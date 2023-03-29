const express = require('express');
const app = express();
const notificationRouter = require('./route/notifications');
const donationRouter = require('./route/donations');
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

app.listen(3000, () => {
  console.log('Server started on port 3000');
});





