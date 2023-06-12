const express = require("express");
const router = express.Router();
const userServices = require("../services/user.services");
const User=require('../models/user');

//routes
router.post("/authenticate", authenticate);
router.post("/register", register);
router.put("/", update);
router.get("/count",count);
router.get("/view",regusers);
module.exports = router;

//route functions
router.get('/delete/:email', async function(req, res) {
  const email = req.params.email;

  try {
    const user = await User.findOneAndDelete({ email: email });

    if (user) {
      res.send('User deleted successfully');
    } else {
      res.status(404).send('User not found');
    }
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
});

 async function regusers(req,res){
  try {
    const users = await User.find();
    res.json(users);
  } catch (err) {
    res.status(500).json({ error: err });
    console.log('err');
  }

}
function count(req,res){
  try{
    User.countDocuments({})
    .then((result) => {
      console.log(result);
      res.status(200).send(result.toString());
    })
    .catch((error) => {
      console.error(error);
      res.status(500).send('An error occurred');
    });

  }catch(error){
    res.status(500).send(error);
  }
}
function authenticate(req, res, next) {
  userServices
    .authenticate(req.body)
    .then((user) => {
      console.log(user);
      user
        ? res.json({ user: user, message: "User logged in successfully" })
        : res
            .status(400)
            .json({ message: "Username or password is incorrect." });
    })
    .catch((error) => next(error));
}

function register(req, res, next) {
  userServices
    .create(req.body)
    .then((user) =>
      res.json({
        user: user,
        message: `User Registered successfully with email ${req.body.email}`,
      })
    )
    .catch((error) => next(error));
}

async function update(req, res, next) {
  try {
    const email = req.body.email;
    const newPassword = req.body.password;

    // Update the user's password
    await userServices.update(email, newPassword);

    // Return success response
    res.json({
      message: `User with email: ${email} updated successfully.`,
    });
  } catch (error) {
    // Pass the error to the error handling middleware
    next(error);
  }
}



