const express = require('express');
const router = express.Router();
const Donation = require('../models/donation');

console.log(Donation);

router.get('/list', async (req, res) => {
    console.log(Donation);

    try {
      const users = await Donation.find();
      res.json(users);
    } catch (err) {
      res.status(500).json({ error: err });
      console.log('err');
    }
  });

router.get('/', (req,res)=>{
    Donation.aggregate([
      {
       $match:{
        id:{$ne:"null"}
       }
      } , 
      {
            $group:{
                _id:"$id",
                totalAmount:{$sum:"$amount"},
            }
        },
        {
          $project: {
            _id: 1,
            totalAmount: 1,
            points:{$trunc: { $divide: ["$totalAmount", 1000] }}
          }
        },
        {
          $sort:{
            totalAmount:-1
          }
        }
    ]).exec((err,result)=>{
        if(err){
            console.log(err);
            res.status(500).send('An error occurred');
        }else{
            res.send(result);
        }
    });
  });
  
  router.post('/',async (req,res)=>
  {
    console.log(req.body);
    // const userdata=req.body;
    // const user=new User(userdata);
    const donation= new Donation({
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

  module.exports =router;