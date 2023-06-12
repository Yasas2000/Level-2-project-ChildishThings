require("rootpath");
var express = require("express");
var path = require("path");
var cookieParser = require("cookie-parser");
var logger = require("morgan");
const cors = require("cors");
const errorHandler = require("./helpers/errorHandler");
const db = require('./db');
const bodyParser=require('body-parser');
const deleteRoutes = require('./routes/deletes');
const donationRoutes=require('./routes/donations')
const feedbackRoutes=require('./routes/feedbacks');
const notificationRoutes=require('./routes/notifications');
const sendEmailRoutes=require('./routes/sendEmails');
const pricingRoutes = require('./routes/pricings');
const eduHelpRoutes=require('./routes/eduHelps');
const financialHelpRoutes=require('./routes/financialHelps');
const nonRegistered=require('./routes/nonRegistered');
var indexRouter = require("./routes/index");
var usersRouter = require("./routes/user.controllers");
const app = express();
const port = process.env.PORT || 3300;

app.use(bodyParser.json());
//app.use(express.json());
app.use(bodyParser.urlencoded({
    extended: true
  }));
// view engine setup
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "jade");

app.use(logger("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, "public")));  

app.use(cors()); 


db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', () => {
  console.log('connected to database');
});

//app.use(express.json());

app.use('/delete', deleteRoutes);
app.use('/donation',donationRoutes);
app.use('/feed',feedbackRoutes);
app.use('/notification',notificationRoutes);
app.use('/send-email',sendEmailRoutes);
app.use('/api', pricingRoutes);
app.use('/edurequest',eduHelpRoutes);
app.use('/financialrequest',financialHelpRoutes);
app.use('/count',nonRegistered);
app.use("/", indexRouter);
app.use("/users", usersRouter);

// catch 404 and forward to error handler
app.use(errorHandler);

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get("env") === "development" ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render("error");
});

app.listen(port, () => {
  console.log(`server started at http://localhost:${port}`);
});