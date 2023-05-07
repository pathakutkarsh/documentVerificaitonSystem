const mongoose= require('mongoose')
//creation of schema for 'user'
const userschema = new mongoose.Schema({
    userId:{
        type: Number,
        required: true
    },

    userName:{
        type: String,
        required: true

    },
    userEmail:{
        type: String,
        required: true
    },
    userPass:{
        type: String,
        required: true
    }

})

module.exports=mongoose.model("User",userschema)


//Code for inserting data into the userschema

// const Userone = mongoose.model('User',userschema)
// const mod = new Userone({
//     userId:1,
//     userName:"user1",
//     userEmail:"user1@gmail.com",
//     userPass:"user1@pass"
// })

// mod.save()