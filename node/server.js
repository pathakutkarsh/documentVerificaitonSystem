//dependencies
const express = require('express')
const morgan = require('./node_modules/morgan')
const cors = require('cors')
const connectDB = require('./config/db')

//acquiring developed routes 
const imageRouter = require('./routes/image_router')
const userRouter=require('./routes/user_router')

//function from db.js is called
connectDB()

const app = express()

//middleware
app.use(express.json())

//cross origin resource sharing
app.use(cors())

//morgan logs requests
//the code below is not being used as we donot require a .env file 
if (process.env.NODE_ENV === 'development') {
    app.use(morgan('dev'))
}

//using routes
app.use('/api/image', imageRouter)
app.use('/api/user',userRouter)

//get static files theough node
app.use(express.static('public'))
app.use('/images',express.static('uploads'))

//port 4000 used
const PORT = 4000

//to convey that port is established
app.listen(PORT, console.log("Server Started"))

//basic welcome msg that displays on the port
app.get("/", (req, res) => {
    // console.log(req)
    // console.log(res)
    res.send("welcome");
    
  });

