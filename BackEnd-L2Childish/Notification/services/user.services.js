const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
const config = require("../config.json");
const User = require("../models/user");


//this will authenticate the user credentials
async function authenticate({ email, password }) {
  //find the user using email

  const user = await User.findOne({ email });
  console.log("user model", user);
  //if user is truthy then sign the token
  if (user && bcrypt.compareSync(password, user.password)) {
    const token = jwt.sign({ sub: user.id, role: user.role }, config.secret, {
      expiresIn: "12m",
    });
    // console.log("user.toJsoon", ...user.toJSON());
    return { ...user.toJSON(), token };
  }
}

//adding user to db
async function create(userParam) {
  //check if user exist
  const user = await User.findOne({ email: userParam.email });
  //validate
  if (user) throw `This email already exists: ${userParam.email}`;

  //create user obj
  const newUser = new User(userParam);
  if (userParam.password) {
    newUser.password = bcrypt.hashSync(userParam.password, 10);
  }

  await newUser.save();
}

async function update(email, newPassword) {
  // Find the user by email
  const user = await User.findOne({ email });

  // Validate that the user exists
  if (!user) {
    throw new Error(`User with email ${email} not found`);
  }

  // Hash the new password
  const hashedPassword = bcrypt.hashSync(newPassword, 10);

  // Update the user's password
  user.password = hashedPassword;

  // Save the updated user object
  await user.save();
}

module.exports = {
  authenticate,
  create,
  update
};
