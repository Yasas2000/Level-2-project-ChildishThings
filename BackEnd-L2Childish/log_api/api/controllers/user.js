const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const User =  require('../models/user');
const { use } = require('../routes/user');
const jwt = require('jsonwebtoken');
require("dotenv").config();

//Create new user for signup
exports.signUpNewUser = (req, res, next) => {
    User.find({email: req.body.email})
    .exec()
    .then(user => {
        if(user.length >= 1){
            return res.status(409).json({
                message: 'Email exists'
            });
        }else{
            bcrypt.hash(req.body.password, 10, (err,hash) =>{
                if(err){
                    return res.status(500).json({
                      error: err
                    });
                }else{
                    const user = new User({
                        _id: new mongoose.Types.ObjectId(),
                        firstName: req.body.firstName,
                        lastName: req.body.lastName,
                        email: req.body.email,
                        phoneno: req.body.phoneno,
                        password: hash
                    });

                    user.save()
                        .then(result => {
                            console.log(result);
                            res.status(201).json({
                                message: 'User created succesfully...!'
                            });
                        })
                        .catch(err => {
                            console.log(err);
                            res.status(500).json({
                                error:err
                            });
                        });
                }
            });
        }   
    });
}

//User login
exports.userSignIn = (req, res, next) => {
    User.find({email: req.body.email})
    .exec()
    .then(user => {
        if(user.length < 1){
            return res.status(404).json({
                message: "Auth Failed"
            });
        }
        bcrypt.compare(req.body.password, user[0].password, (err, result) => {
            if(err){
                return res.status(404).json({
                    message: "Auth failed"
                });
            }
            if(result){
                const token = jwt.sign({
                    email: user[0].email,
                    userId: user[0]._id
                },
                process.env.JWT_KEY,
                {
                    expiresIn: "1d"
                }
                );
                return res.status(200).json({
                    message: "Auth Successful...",
                    token: token
                });
            }
            res.status(400).json({
                message: "Auth failed"
            });
        });
    })
    .catch(err => {
        console.log(err);
        res.status(500).json({
            error: err
        });
    });
}

//get user
exports.getAllUser = (req, res) => {
    User.find({})
    .exec()
    .then(result => {
        //const users = userList('',result);
        res.status(200).json(result);
    })
    .catch(err => {
        res.status(500).json({
            error: err
        });
    });
}

//Delete User
exports.deleteUser = (req, res, next) => {
    User.remove({_id: req.params.userId})
    .exec()
    .then(result => {
        console.log(result);
        res.status(200).json({
            message: 'User deleted'
        });
    })
    .catch(err =>{
        console.log(err);
        res.status(500).json({
            error: err
        });
    });
}

