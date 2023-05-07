const express = require('express')
const router = express.Router()

//acquiring user model
const User = require('../models/user')

module.exports=router

//api to get all registered users

router.get('/getUSer',async(req, res)=>{
    try {
        const users = await User.find()
        res.status(200).json({users:users})
    }
    catch (err) {
        res.status(500).json({ message: err.message })
    }
})

//api to register a user

router.post('/postUser',async(req, res)=>{
    const addUser = new User({
        userId:req.body.userId,
        userName:req.body.userName,
        userEmail:req.body.userEmail,
        userPass:req.body.userPass
    })
    try {
        const newUser= await addUser.save();
        res.status(201).json({ User: newUser})
    } catch (error) {
        res.status(400).json({message: error.message })
    }
})
