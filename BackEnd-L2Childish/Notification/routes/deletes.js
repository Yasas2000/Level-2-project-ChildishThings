const express = require('express');
const router = express.Router();
const DeletedNots = require('../models/delete');

router.post('/',async(req,res)=>{
    const deletednots=new DeletedNots({
      uid:req.body.uid,
      oid:req.body.oid
    });
    deletednots.save((err)=>
    {
      if(err){
        console.log('Error');
        res.status(500).send(err);
    } else{
        console.log('success');
        res.send('Deleted Success');
    }
    });
});

router.get('/:userId', (req, res) => {
    console.log(DeletedNots);
    try{
    DeletedNots.find({uid: req.params.userId }, (err, deletions) => {
      if (err) {
        res.status(500).send(err);
      } else {
        res.send(deletions);
      }
    });
}catch(err){
    res.send(err);
}
  });

module.exports=router;