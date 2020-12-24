const mongoose = require('mongoose')
const dbConfig = require('./dbconfig')

const connectDB = async() => {
    try{
        const conn = await mongoose.connect(dbConfig.database,
            {
                useNewUrlParser: true,
                useUnifiedTopology:true,
                useFindAndModify:false
            })
        console.log(`\n\n====================================\nconnected to database: ${conn.connection.host}\n`)
    }
    catch (err){
        console.log(err)
        process.exit(1)
    }
}

module.exports = connectDB