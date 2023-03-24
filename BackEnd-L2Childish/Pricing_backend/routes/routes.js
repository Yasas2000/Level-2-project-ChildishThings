    const express = require('express');
    const router = require('express').Router();
    const group = require('../models/group');
    const group1 = require('../models/group1');
    const StripesTiles = require('../models/StripesTiles');
    const custom = require('../models/custom');
    const portrait = require('../models/portrait');
    const portrait1 = require('../models/portrait1');
    const mailgun = require("mailgun.js");
      
    

    module.exports = router;



    //Post Method
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
          /*const DOMAIN = 'sandbox6135c10ee8d94aef9baebf43dcae92ad.mailgun.org';
        const api_key = '312a2a96f28ad911deee060b0937e7e4-7764770b-7e8c9bbd';
        const mg = mailgun({apiKey: api_key, domain: DOMAIN});
        const data = {
          from: 'chamiladeza@yahoo.com',
          to: 'devinmmcs@gmail.com',
          subject: 'Portrait submission',
          text: 'Testing some Mailgun awesomness!'
        };*/
            res.status(200).json(dataToSave);
          })
          .catch(error => {
            res.status(400).json({message: error.message});
          });
        }); 
   
    
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
        
        /*const DOMAIN = 'sandbox6135c10ee8d94aef9baebf43dcae92ad.mailgun.org';
        const api_key = '312a2a96f28ad911deee060b0937e7e4-7764770b-7e8c9bbd';
        const mg = mailgun({apiKey: api_key, domain: DOMAIN});
        const data = {
          from: 'chamiladeza@yahoo.com',
          to: 'devinmmcs@gmail.com',
          subject: 'Stripes submission',
          text: 'Testing some Mailgun awesomness!'
        };
        mg.messages().send(data, function (error, body) {
          console.log(body);
        });
        */
        res.status(200).json(dataToSave);
      })
      .catch(error => {
        res.status(400).json({message: error.message});
      });
    });
    
    





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

 


    //Get all Method
    router.get('/getAll', (req, res) => {
        group.find().then((result)=>{
            res.send(result);
        }).catch((error)=>{
            console.log(error);
        })
    })

    router.get('/getAll1', (req, res) => {
        group1.find().then((result)=>{
            res.send(result);
        }).catch((error)=>{
            console.log(error);
        })
    })

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

    router.get('/getPortraitValue', (req, res) => {
        portrait.findOne({}).then((result) => {
            if (result) {
                res.send(result);
            } else {
                res.status(404).send({ error: 'Portrait value not found' });
            }
        }).catch((error) => {
            console.log(error);
            res.status(500).send({ error: 'Something went wrong' });
        });
    });

    
    //Get by ID Method
    router.get('/getgroup', (req, res) => {
        group.findById('').then((result)=>{
            res.send(result);
        }).catch((error)=>{
            console.log(error);
        })
    })
    router.get('/getgroup1', (req, res) => {
        group1.findById('63d6ac1895a0be793cc69452').then((result)=>{
            res.send(result);
        }).catch((error)=>{
            console.log(error);
        })
    })

   
    router.get('/getAllStripes', (req, res) => {
        StripesTiles.find().then((result)=>{
            res.send(result);
        }).catch((error)=>{
            console.log(error);
        })
    })

    //Update by ID Method
    router.patch('/updategroup', (req, res) => {
        
      });

      router.patch('/updategroup1', (req, res) => {
        
      });

      router.put('/updateCustomValue', (req, res) => {
        custom.findOneAndUpdate({}, { $set: { amount: req.body.amount } }, { new: true }, (err, customValue) => {
          if (err) return res.status(500).send(err);
          console.log("req")
          console.log(req.body);
          
          return res.send(customValue);
        });
        
      });

      router.put('/updatePortraitValue', (req, res) => {
        portrait.findOneAndUpdate({}, { $set: { amount: req.body.amount,
            
        
        } }, { new: true }, (err, PortraitValue) => {
          if (err) return res.status(500).send(err);
          console.log("req")
          console.log(req.body);
          
          return res.send(PortraitValue);
        });
        
      });

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
      
      

    //Delete by ID Method


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
      


    module.exports = router;