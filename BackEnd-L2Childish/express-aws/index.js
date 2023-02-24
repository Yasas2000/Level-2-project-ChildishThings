const express = require('express')
const AwsClient = require('./awsClient')
const multer = require('multer')
const AWS3 = require('@aws-sdk/client-s3')
const { ListObjectsV2Command, GetObjectCommand } = require('@aws-sdk/client-s3');
const { getSignedUrl } = require('@aws-sdk/s3-request-presigner'); 
require('dotenv').config()

const upload = multer({})
const app = express()

const folderKeys = ['single/', 'multiple/'];

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
        let uploadParams = {Key: fileName, Bucket: process.env.S3_BUCKET_NAME,Body: req.file.buffer}
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
          Bucket: process.env.S3_BUCKET_NAME,
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

// API endpoint to get the list of images
app.get('/images', async (req, res) => {
  try {
    const listParams = { Bucket: process.env.S3_BUCKET_NAME };
    const data = await AwsClient.s3Instance.send(new ListObjectsV2Command(listParams));
    const objects = data.Contents.filter(obj => folderKeys.some(key => obj.Key.startsWith(key)));
    const imageObjects = objects.filter(obj => obj.Key.match(/\.(jpg|jpeg|png|gif)$/i));
    const imageUrls = await Promise.all(imageObjects.map(async obj => {
      const getObjectParams = { Bucket: process.env.S3_BUCKET_NAME, Key: obj.Key };
      const getObjectCommand = new GetObjectCommand(getObjectParams);
      const url = await getSignedUrl(AwsClient.s3Instance, getObjectCommand, { expiresIn: 3600 });
      return url;
    }));
    res.status(200).json({ images: imageUrls });
  } catch (err) {
    console.log(err);
    res.status(500).send('Error retrieving images from S3 bucket');
  }
});



// Start the server 

app.listen(3000, () => {
    console.log('Server is running')
})