require("dotenv").config();
const express = require('express');
const morgan = require('morgan');
const app = express();
const bodyParser = require('body-parser');
const mongoose = require('mongoose');

const userRoutes = require('./api/routes/user');
mongoose.set("strictQuery", false);
mongoose.connect('mongodb+srv://userone:suV5g8jG9TXIrwRr@cluster0.85gnlm3.mongodb.net/signup_db?retryWrites=true&w=majority',{
    useUnifiedTopology: true,
    useNewUrlParser: true
})



app.use(morgan('dev'));
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

app.use((req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers","Origin,X-Requested-With,Content-Type,Accept,Authorization");

    if(req.method === "OPTIONS"){
        res.header("Access-Control-Allow-Method", "PUT, POST, PATCH, DELETE, GET");
        return res.status(200).json({});
    }
    next();
}); 

app.use('/api/user',userRoutes);

app.use((req, res, next) => {
    const error = new Error('Not found');
    error.status = 400;
    next(error);
});

app.use((error, req, res, next) => {
    res.status(error.status || 500);
    res.json({
        error: {
            message: error.message
        }
    });
});

module.exports = app;