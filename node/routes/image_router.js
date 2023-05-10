const express = require('express')
const router = express.Router()
const multer =require('multer')

//acquiring image model

const Image = require('../models/image')

module.exports=router

//api to  get all images

router.get('/getImage',async(req, res)=>{
    try {
        const images = await Image.find()
        res.status(200).json({images:images})
    }
    catch (err) {
        res.status(500).json({ message: err.message })
    }
})

//api to get image by id (userid)

router.get('/getImagebyId/:id',async(req, res)=>{
    try {
        const userid = await Image.findOne({userId:req.params.id})
        res.status(201).json({userId:userid})
        
    } catch (error) {
        return res.status(500).json({message:error.message})
    }
})

//api to get image by id (imageid)
router.get('/getImagebyUserId/:id',async(req, res)=>{
    try {
        const imageid = await Image.findOne({imageId:req.params.id})
        res.status(201).json({imageId:imageid})
        
    } catch (error) {
        return res.status(500).json({message:error.message})
    }
})

// diskstorage
const Storage = multer.diskStorage({
    destination:'uploads', 
    filename:  (req, file, cb) =>{
      cb(null, file.originalname)
    }
  })
  
const upload = multer({ 
     storage: Storage 
}).single('testImage')


//api to post image details to mongo and add image to 'uploads' folder
router.post('/postImage',async(req, res)=>{
    upload(req,res,(err)=>{
        if (err){
            console.log(err)
        }
       else{
            const addImage = new Image({
            imageId:req.body.imageId,
            imageName:req.body.imageName,
            imagDoc:{
                data: req.file.filename,
                contentType: 'image/jpg'
            },
            userId:req.body.userId,
            requestedById:req.body.requestedById
        })
       
       addImage.save()
       .then(()=>res.send('sucessfully uploaded'))
       .catch(err=>console.log(err))
    }}
)
})

