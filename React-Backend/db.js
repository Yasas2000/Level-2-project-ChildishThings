const mongoose=require('mongoose');

mongoose.connect("mongodb://localhost:27017/gbs",{useNewUrlParser: true,  useUnifiedTopology: true },
function checkDb(error)
{
    if(error)
    {
        console.log("Error Connecting to DB");
    }
    else
    {
        console.log("successfully Connected to DB");
    }
});

module.exports=mongoose.connection;