const express = require('express');
const router = express.Router();
const Request = require('../models/financialHelp');
router.post('/', async(req, res) => {

    try{
        const request = await Request.create(req.body)
        res.status(200).json(request);
        
    } catch(error){
        console.log(error.message);
        res.status(500).json({message: error.message})
    }
});
router.get('/list', async (req, res) => {

    try {
      const request = await Request.find();
      res.json(request);
    } catch (err) {
      res.status(500).json({ error: err });
      console.log('err');
    }
  });

  router.get('/deleteRequest/:oid', function(req, res) {
    const oid=req.params.oid; 
  
  Request.findByIdAndDelete(oid, function(err, request) {
    if (err) {
    console.log(err);
    res.status(500).send(err);
    return;
    }
    
    if (request) {
    res.send('Request deleted successfully');
    } else {
    res.status(404).send('Stripe not found');
    }
});
});
module.exports=router;