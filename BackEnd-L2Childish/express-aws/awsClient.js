const AWS3 = require('@aws-sdk/client-s3')
require('dotenv').config();



const s3Instance = new AWS3.S3Client({  //Creates an instance of S3 Client
    region: process.env.AWS_REGION,
    credentials: {
      accessKeyId: process.env.AWS_ACCESS_KEY_ID,
      secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY
    }
  })
module.exports = {
    s3Instance
}