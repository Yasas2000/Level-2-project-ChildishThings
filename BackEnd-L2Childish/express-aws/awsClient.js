const AWS3 = require('@aws-sdk/client-s3')

const accessKeyId = 'AKIAR574FXEGTQFSYLNE'
const secretKey = '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'


//v3 config
const s3Instance = new AWS3.S3Client({
    region: 'ap-south-1',
    credentials: {
      accessKeyId,
      secretAccessKey: secretKey
    }
  })
module.exports = {
    s3Instance
}