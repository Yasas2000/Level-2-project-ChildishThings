const express = require('express');
const router = express.Router();
const Feedback = require('../models/feedback');

router.post('/',(req,res)=>
{
    console.log(req.body);
    const feedback=new Feedback({
      uid:req.body.uid,
      rating:req.body.rating,
      comment:req.body.comment,
      dt:req.body.dtS
    });

    feedback.save((err)=>
{
    if(err){
        console.log('Error');
        res.status(500).send(err);
    } else{
        console.log('success');
        res.send('Feedback submitted successfully');
    }
});

});

router.get('/',async (req,res)=>{
    try {
        const feedback = await Feedback.find();
        res.json(feedback);
      } catch (err) {
        res.status(500).json({ error: err });
        console.log('err');
      }

});

module.exports=router;