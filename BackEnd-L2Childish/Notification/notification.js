const express = require('express');
const mongoose = require('mongoose');
const app = express();

mongoose.connect('mongodb://localhost:27017/form', {useNewUrlParser: true});

const notificationSchema = new mongoose.Schema({
  _uid: String,
  _not: String
});

const Notification = mongoose.model('notifications', notificationSchema);

app.get('/notifications/:userId', (req, res) => {
  Notification.find({_uid: req.params.userId}, (err, notifications) => {
    if (err) {
      res.status(500).send(err);
    } else {
      res.send(notifications);
    }
  });
});

app.listen(3000, () => {
  console.log('Server started on port 3000');
});