const mongoose=require('mongoose')

//acquiring connection link
const dbConfig=require('./dbconfig.js')

//database connection using dbconfig
const connectDB=async()=>{
        try{
            const conn=await mongoose.connect(
                dbConfig.database,
                {useNewUrlParser:true,
                useUnifiedTopology:true}
            )
            .then(()=>console.log("DB connected"))
        }
        catch(error){
            console.log(error)
            process.exit(1)
        }
}

module.exports =connectDB