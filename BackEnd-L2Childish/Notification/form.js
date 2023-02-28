const express=require('express');
const bodyParser=require('body-parser');
const mongoose=require('mongoose');

const app=express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
    extended: true
  }));

mongoose.connect('mongodb://localhost:27017/mydb',{
    useNewUrlParser:true,
    useUnifiedTopology:true
});

const logsSchema = new mongoose.Schema(
    {
        id:String,
        pid:String,
        amount:String,
        method:String,
        lname:String,
        fname:String,
        email:String,

    }
);
const User =mongoose.model('Donations',logsSchema);
 
app.post('/submit',(req,res)=>
{
    console.log(req.body);
    const user= new User({
        id:req.body.id,
        pid:req.body.pid,
        amount:req.body.amount,
        method:req.body.method,
        lname:req.body.lname,
        fname:req.body.fname,
        email:req.body.email,
        
    });

    user.save((err)=>
{
    if(err){
        console.log('Error');
        res.status(500).send(err);
    } else{
        console.log('success');
        res.send('Form submitted successfully');
    }
});

});

app.listen(3000,()=>{
    console.log('Server listening on port 3000')
});