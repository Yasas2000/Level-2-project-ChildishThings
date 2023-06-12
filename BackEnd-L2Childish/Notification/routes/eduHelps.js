const express = require('express');
const router = express.Router();
const Request = require('../models/eduHelp');
const FinancialRequest=require('../models/financialHelp');
router.get('/RequestCount', (req, res) => {
    Promise.all([
      Request.aggregate([
        {
          $group: {
            _id: null,
            totalCount: { $sum: 1 },
          },
        },
      ]).exec(),
      FinancialRequest.aggregate([
        {
          $group: {
            _id: null,
            totalCount: { $sum: 1 },
          },
        },
      ]).exec(),
    ])
      .then((results) => {
        const totalCount = results.reduce((sum, result) => sum + (result[0]?.totalCount || 0), 0);
        console.log('Total count:', totalCount);
        res.status(200).send(totalCount.toString());
      })
      .catch((error) => {
        console.error('Failed to get the total count:', error);
        res.status(500).send('An error occurred');
      });
  });

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