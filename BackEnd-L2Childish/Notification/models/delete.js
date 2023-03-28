const mongoose=require('mongoose');

const deletedNotsSchema=new mongoose.Schema({
    uid:String,
    oid:String
  });

const DeletedNots=mongoose.model('deletednots',deletedNotsSchema);

module.exports=DeletedNots;