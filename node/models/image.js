const mongoose= require('mongoose')
//creation of schema for 'image'
const imageschema = new mongoose.Schema({

    imageId:{
        type: Number,
        required: true
    },
    imageName:{
        type: String,
        required: true

    },
    imageUrl:{
        type: String,
        required: true

    },
    userId:{
        type: Number,
        required: true
    },
    requestedById:{
        type: Number,
        required: true 
    }


})

module.exports=mongoose.model("Image",imageschema)


//Code for inserting data into the imageschema

// const imageone = mongoose.model('Image',imageschema)
// const mod = new imageone({
//     imageId:"2",
//     imageName:"Image2",
//     imageUrl:"ImageURL2",
//     userId:2,
//     requestedById:2
// })

// mod.save()