const express = require("express");
const router = express.Router();
const userServices = require("../services/user.services");

//routes
router.post("/authenticate", authenticate);
router.post("/register", register);
router.put("/", update);
module.exports = router;

//route functions
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



