const express = require('express')
const mongoose = require('mongoose')
const AwsClient = require('./awsClient')
const multer = require('multer')          //middleware used for filed uploads
const AWS3 = require('@aws-sdk/client-s3')
const { ListObjectsV2Command, GetObjectCommand, DeleteObjectCommand } = require('@aws-sdk/client-s3');
const { getSignedUrl } = require('@aws-sdk/s3-request-presigner');    //function that generates a presigned URL
require('dotenv').config()

const upload = multer({});
const app = express();

app.use(express.json());

// Connect to MongoDB
mongoose.connect('mongodb+srv://ekanayakaym20:2ilctvjCgYFhYP2W@cluster0.vyyy7ro.mongodb.net/Childish-Backend?retryWrites=true&w=majority', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});
mongoose.connection.on('error', console.error.bind(console, 'MongoDB connection error:'));

// Create a Comment schema
const commentSchema = new mongoose.Schema({
  content: String,
  createdAt: { type: Date, default: Date.now }
});

// Create a Comment model
const Comment = mongoose.model('Comment', commentSchema);




const folderKeys = ['single/', 'multiple/'];

app.post('/v3/post/single', upload.single('file'),async(req, res)=>{
    try{
        const fileName = `single/${Date.now()}-${req.file.originalname}`
        let uploadParams = {Key: fileName, Bucket: process.env.S3_BUCKET_NAME,Body: req.file.buffer}
        const command = new AWS3.PutObjectCommand(uploadParams)         //creates a commands object
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

// API endpoint to save a new comment
app.post('/comments', async (req, res) => {
  try {
    const { content } = req.body;

    // Create a new comment
    const comment = new Comment({
      content,
      createdAt: new Date()
    });

    // Save the comment to the database
    await comment.save();

    res.status(201).json({ message: 'Comment saved successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'An error occurred' });
  }
});

app.get('/comments', async (req, res) => {
  try {
    // Retrieve all comments from the database
    const comments = await Comment.find();
    res.json(comments);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});




// Start the server 
const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
})