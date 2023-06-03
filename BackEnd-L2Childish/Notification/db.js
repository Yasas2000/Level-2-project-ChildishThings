const mongoose = require('mongoose');

mongoose.connect('mongodb+srv://ekanayakaym20:2ilctvjCgYFhYP2W@cluster0.vyyy7ro.mongodb.net/Childish-Backend?retryWrites=true&w=majority', {
    useNewUrlParser: true,
    useUnifiedTopology:true
});
mongoose.Promise=global.Promise;

module.exports = mongoose.connection;