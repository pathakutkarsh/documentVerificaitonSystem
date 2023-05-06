const express = require('express')
const router = express.Router()

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

//api to post images

router.post('/postImage',async(req, res)=>{
    const addImage = new Image({
        imageId:req.body.imageId,
        imageName:req.body.imageName,
        imageUrl:req.body.imageUrl,
        userId:req.body.userId,
        requestedById:req.body.requestedById
    })
    try {
        const newImage= await addImage.save();
        res.status(201).json({ image: newImage})
    } catch (error) {
        res.status(400).json({message: error.message })
    }
})

//api to get image by id (userid)

router.get('/getImagebyid/:id',async(req, res)=>{
    try {
        const userid = await Image.findOne({userId:req.params.id})
        res.status(201).json({userId:userid})
        
    } catch (error) {
        return res.status(500).json({message:error.message})
    }
})

//api to get image by id (imageid)

