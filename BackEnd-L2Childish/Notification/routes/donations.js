const express = require('express');
const router = express.Router();
const Donation = require('../models/donation');
const currentMonth = new Date().getMonth() + 1; // Get current month (1-12)
const currentYear = new Date().getFullYear(); // Get current year

console.log(Donation);

router.get('/delete-donation/:oid', function(req, res) {
  const oid=req.params.oid; 

  Donation.findByIdAndDelete(oid, function(err, donation) {
    if (err) {
      console.log(err);
      res.status(500).send(err);
      return;
    }
    
    if (donation) {
      res.send('Donation deleted successfully');
    } else {
      res.status(404).send('Donation not found');
    }
  });
});
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

  router.get('/count', (req, res) => {
    Donation.countDocuments({})
      .then((result) => {
        console.log(result);
        res.status(200).send(result.toString());
      })
      .catch((error) => {
        console.error(error);
        res.status(500).send('An error occurred');
      });
  });
  
router.get('/totalDonations',(req,res)=>{

    Donation.aggregate([
        {
          $match: {
            
          },
        },
        {
          $group: {
            _id: null,
            total: { $sum: "$amount" }, // Sum the amount field
          },
        },
        {
          $project: {
            _id: 0,
            total: 1,
          },
        },
      ])
        .then((result) => {
          console.log(result);
          res.send(result);
        })
        .catch((error) => {
          console.error(error);
        });
});  
router.get('/sumOfmonth',(req,res)=>{
    Donation.aggregate([
        {
          $match: {
            // Filter donations for current month and year
            date: {
              $gte: new Date(`${currentYear}-${currentMonth}-01`),
              $lte: new Date(`${currentYear}-${currentMonth}-31`),
            },
          },
        },
        {
          $group: {
            _id: null,
            total: { $sum: "$amount" }, // Sum the amount field
          },
        },
        {
          $project: {
            _id: 0,
            total: 1,
          },
        },
      ])
        .then((result) => {
          console.log(result);
          res.send(result);
        })
        .catch((error) => {
          console.error(error);
        });

});
router.get('/sumOfLastFiveMonths', (req, res) => {
  const currentYear = new Date().getFullYear();
  const currentMonth = new Date().getMonth() + 1;
  const lastFiveMonths = [];

  for (let i = 0; i < 5; i++) {
    const month = currentMonth - i;
    const year = currentYear - Math.floor((currentMonth - month) / 12);
    lastFiveMonths.push({
      $match: {
        date: {
          $gte: new Date(`${year}-${month}-01`),
          $lte: new Date(`${year}-${month}-31`),
        },
      },
    });
  }

  Donation.aggregate([
    ...lastFiveMonths,
    {
      $group: {
        _id: {
          month: { $month: '$date' },
          year: { $year: '$date' },
        },
        total: { $sum: '$amount' },
      },
    },
    {
      $project: {
        _id: 0,
        month: '$_id.month',
        year: '$_id.year',
        total: 1,
      },
    },
    {
      $sort: { year: 1, month: 1 },
    },
  ])
    .then((results) => {
      const formattedResults = {};
      results.forEach((result) => {
        const { month, year, total } = result;
        const monthYear = `${year}-${month}`;
        formattedResults[monthYear] = total;
      });

      console.log(formattedResults);
      res.send(formattedResults);
    })
    .catch((error) => {
      console.error(error);
      res.status(500).send('An error occurred while retrieving donations.');
    });
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
  
    donation.save((err)=>
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