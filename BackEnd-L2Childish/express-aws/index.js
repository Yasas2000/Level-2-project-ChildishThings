const express = require('express')
const AwsClient = require('./awsClient')
const multer = require('multer')
const AWS3 = require('@aws-sdk/client-s3')
const { getSignedUrl } = require('@aws-sdk/s3-request-presigner');
const { S3Client, ListObjectsCommand, GetObjectCommand } = require('@aws-sdk/client-s3');


const upload = multer({})
const app = express()

//v3
app.get('/v3/buckets',async (req, res) => {
    try{
        const command = new AWS3.ListBucketsCommand({})
        const response = await AwsClient.s3Instance.send(command)
        res.send(response.Buckets)
    }catch (error){
        console.log(error)
        res.send(error)
    }
    
})

app.post('/v3/post/single', upload.single('file'),async(req, res)=>{
    try{
        const fileName = `single/${Date.now()}-${req.file.originalname}`
        let uploadParams = {Key: fileName, Bucket: 'testone-flutter-photoboothme',Body: req.file.buffer}
        const command = new AWS3.PutObjectCommand(uploadParams)
        const response = await AwsClient.s3Instance.send(command)
        if(response.$metadata.httpStatusCode === 200) res.send('success')
    }catch (error){
        console.log(error)
    }
})


app.post('/v3/post/multiple', upload.array('files',10), async (req, res) => {
    try {
      const files = req.files
      const uploadedFiles = []
  
      for (let i = 0; i < files.length; i++) {
        const file = files[i]
        const fileName = `multiple/${Date.now()}-${file.originalname}`
        const uploadParams = {
          Key: fileName,
          Bucket: 'testone-flutter-photoboothme',
          Body: file.buffer
        }
        const command = new AWS3.PutObjectCommand(uploadParams)
        const response = await AwsClient.s3Instance.send(command)
        if (response.$metadata.httpStatusCode === 200) {
          uploadedFiles.push(fileName)
        }
      }
  
      res.send({ uploadedFiles })
    } catch (error) {
      console.log(error)
      res.send(error)
    }
  })


  
  

app.listen(3000, () => {
    console.log('Server is running')
})