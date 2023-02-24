const AWS3 = require('@aws-sdk/client-s3')
require('dotenv').config();


//v3 config
const s3Instance = new AWS3.S3Client({
    region: process.env.AWS_REGION,
    credentials: {
      accessKeyId: process.env.AWS_ACCESS_KEY_ID,
      secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY
    }
  })
module.exports = {
    s3Instance
}