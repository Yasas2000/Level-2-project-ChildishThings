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
module.exports=router;