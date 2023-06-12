const expressJwt = require("express-jwt");
const config = require("../config.json");
const User = require("../models/user");
function jwt(roles = []) {
  // roles param can be a single role string (e.g. Role.User or 'User')
  // or an array of roles (e.g. [Role.Admin, Role.User] or ['Admin', 'User'])
  if (typeof roles === "string") {
    roles = [roles];
    console.log(roles);
  }
  const secret = config.secret;
  return [
    // authenticate JWT token and attach user to request object (req.user)
    expressJwt({ secret, algorithms: ["HS256"] }),

    // authorize based on user role
    async (req, res, next) => {
      const user = await User.findById(req.user.sub);

      if (!user || (roles.length && !roles.includes(user.role))) {
        // user's role is not authorized
        return res.status(401).json({ message: "Only Admin is Authorized!" });
      }
      // authentication and authorization successful
      req.user.role = user.role;
      next();
    },
  ];
}
module.exports = jwt;
