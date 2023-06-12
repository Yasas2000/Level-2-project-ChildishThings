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
router.get('/deleteFeedback/:oid', function(req, res) {
  const oid=req.params.oid; 

Feedback.findByIdAndDelete(oid, function(err, feedback) {
  if (err) {
  console.log(err);
  res.status(500).send(err);
  return;
  }
  
  if (feedback) {
  res.send('Request deleted successfully');
  } else {
  res.status(404).send('Stripe not found');
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