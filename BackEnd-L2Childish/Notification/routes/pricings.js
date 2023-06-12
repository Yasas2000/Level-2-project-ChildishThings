    const express = require('express');
    const router = require('express').Router();
    const group = require('../models/group');
    const group1 = require('../models/group1');
    const StripesTiles = require('../models/StripesTiles');
    const custom = require('../models/custom');
    const portrait = require('../models/portrait');
    const portrait1 = require('../models/portrait1');
 
   
      
    
    module.exports = router;



    //Post Method
    //saving the data of portrait quotation
    router.post('/post', (req, res)=> {
        let newGroup = new group();
        newGroup.numBigFamilies = req.body.numBigFamilies,
        newGroup.firstName= req.body.firstName,
        newGroup.lastName= req.body.lastName,
        newGroup.contactNumber= req.body.contactNumber,
        newGroup.email=req.body.email,
        newGroup.eventStarttime= req.body.eventStarttime,
        newGroup.date= req.body.date,
        newGroup.eventDurationHours= req.body.eventDurationHours,
        newGroup.eventLocation=req.body.eventLocation,
        newGroup.totInvitees=req.body.totInvitees,
        newGroup.remarks=req.body.remarks,
        newGroup.numSmallFamilies=req.body.numSmallFamilies,
        newGroup.numMarriedCouples=req.body.numMarriedCouples,
        newGroup.numUnMarriedCouples=req.body.numUnMarriedCouples,
        newGroup.numIndividualInvitees=req.body.numIndividualInvitees,  

        //Save in database
        newGroup.save()
        .then(dataToSave => {
          
        res.status(200).json(dataToSave);
      })
      .catch(error => {
        res.status(400).json({message: error.message});
      });
    });
    
    
      
   //saving the data of stripes quotation
    
    router.post('/Stripes', (req, res)=> {
      let newGroup1 = new group1();
      newGroup1.firstName= req.body.firstName,
      newGroup1.lastName= req.body.lastName,
      newGroup1.contactNumber= req.body.contactNumber,
      newGroup1.email=req.body.email,
      newGroup1.eventStarttime= req.body.eventStarttime,
      newGroup1.date= req.body.date,
      newGroup1.eventDurationHours= req.body.eventDurationHours,
      newGroup1.eventLocation=req.body.eventLocation,
      newGroup1.totInvitees=req.body.totInvitees,
      newGroup1.remarks=req.body.remarks,
    
      // Save in database
      newGroup1.save()
      .then(dataToSave => {
        
        
        res.status(200).json(dataToSave);
      })
      .catch(error => {
        res.status(400).json({message: error.message});
      });
    });
    
    



//add stripe tiles

    router.post('/addStripTile', (req, res)=> {
        let newStripe = new StripesTiles();
        newStripe.imageAsset= req.body.imageAsset,
        newStripe.text= req.body.text,
        newStripe.amount=req.body.amount,
        newStripe.hour=req.body.hour,
        

        //Save in database
        newStripe.save()
        .then(dataToSave => {
            res.status(200).json(dataToSave);
        })
        .catch(error => {
            res.status(400).json({message: error.message});
        });
    });

    router.get('/stripeQuotation', async (req, res) => {
  
      try {
        const users = await group1.find();
        res.json(users);
      } catch (err) {
        res.status(500).json({ error: err });
        console.log('err');
      }
    });
    router.get('/portraitQuotation', async (req, res) => {
  
      try {
        const users = await group.find();
        res.json(users);
      } catch (err) {
        res.status(500).json({ error: err });
        console.log('err');
      }
    });

    router.get('/deletePortrait/:oid', function(req, res) {
      const oid=req.params.oid; 
    
      group.findByIdAndDelete(oid, function(err, portrait) {
        if (err) {
          console.log(err);
          res.status(500).send(err);
          return;
        }
        
        if (portrait) {
          res.send('Portrait deleted successfully');
        } else {
          res.status(404).send('Donation not found');
        }
      });
    });

   router.get('/deleteStripes/:oid', function(req, res) {
      const oid=req.params.oid; 
    
      group1.findByIdAndDelete(oid, function(err, stripe) {
        if (err) {
          console.log(err);
          res.status(500).send(err);
          return;
        }
        
        if (stripe) {
          res.send('Stripe deleted successfully');
        } else {
          res.status(404).send('Stripe not found');
        }
      });
    });

  


    //getting the custom value which was updated
    router.get('/getCustomValue', (req, res) => {
        custom.findOne({}).then((result) => {
            if (result) {
                res.send(result);
            } else {
                res.status(404).send({ error: 'Custom value not found' });
            }
        }).catch((error) => {
            console.log(error);
            res.status(500).send({ error: 'Something went wrong' });
        });
    });

    //getting the portrait value which was updated
    router.get('/getPortraitValue', (req, res) => {
        portrait.findOne({}).then((result) => {
            if (result) {
                res.send(result);
                console.log(result);
            } else {
                res.status(404).send({ error: 'Portrait value not found' });
            }
        }).catch((error) => {
            console.log(error);
            res.status(500).send({ error: 'Something went wrong' });
        });
    });

    router.get('/getPortraitValue1', (req, res) => {
      portrait1.findOne({}).then((result) => {
          if (result) {
              res.send(result);
              console.log(result);
          } else {
              res.status(404).send({ error: 'Portrait value not found' });
          }
      }).catch((error) => {
          console.log(error);
          res.status(500).send({ error: 'Something went wrong' });
      });
  });

    
 

   
    router.get('/getAllStripes', (req, res) => {
        StripesTiles.find().then((result)=>{
            res.send(result);
        }).catch((error)=>{
            console.log(error);
        })
    })



      //updating the custom vlaue
      router.put('/updateCustomValue', (req, res) => {
        custom.findOneAndUpdate({}, { $set: { amount: req.body.amount } }, { new: true }, (err, customValue) => {
          if (err) return res.status(500).send(err);
          console.log("req")
          console.log(req.body);
          
          return res.send(customValue);
        });
        
      });


      //updating the portrait vlaue(with out frame)
      router.put('/updatePortraitValue', (req, res) => {
        portrait.findOneAndUpdate({}, { $set: { amount: req.body.amount,
            
        
        } }, { new: true }, (err, PortraitValue) => {
          if (err) return res.status(500).send(err);
          console.log("req")
          console.log(req.body);
          
          return res.send(PortraitValue);
        });
        
      });


      //updating the portrait vlaue(with frame)
      router.put('/updatePortraitValue1', (req, res) => {
        portrait1.findOneAndUpdate({}, { $set: { 
            amount1: req.body.amount1
        
        } }, { new: true }, (err, PortraitValue) => {
          if (err) return res.status(500).send(err);
          console.log("req")
          console.log(req.body);
          
          return res.send(PortraitValue);
        });
        
      });
      
      

  

//delete a stripe tile
    router.delete('/deleteStripes', async (req, res) => {
        try {
          const text = req.body.text;
      
          // Find and delete the stripe tile by text
          const deletedStripeTile = await StripesTiles.findOneAndDelete({ text: text });
      
          if (deletedStripeTile) {
            return res.status(200).json({ message: `Stripe tile with text "${text}" deleted successfully.` });
          } else {
            return res.status(404).json({ message: `Stripe tile with text "${text}" not found.` });
          }
        } catch (error) {
          console.error(error);
          res.status(500).json({ message: 'An error occurred while deleting the stripe tile.' });
        }
      });
      
      router.get('/QuotationCount', (req, res) => {
        Promise.all([
          group.aggregate([
            {
              $group: {
                _id: null,
                totalCount: { $sum: 1 },
              },
            },
          ]).exec(),
          group1.aggregate([
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
    
