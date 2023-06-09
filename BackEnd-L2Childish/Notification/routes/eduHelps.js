const express = require('express');
const router = express.Router();
const Request = require('../models/eduHelp');
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