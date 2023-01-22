const express = require('express');
const router = express.Router();
const userController = require('../controllers/user');

//Sign up URL
router.post('/signup', userController.signUpNewUser);

//Sign In url
router.post('/signin',userController.userSignIn);

//get all user
router.get('/users', userController.getAllUser);

//Delete user
router.delete('/:userId', userController.deleteUser);
module.exports = router;