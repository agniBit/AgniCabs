const express = require('express')
const morgan = require('morgan')
const cors = require('cors')
const connectDB = require('./config/db')
const passport = require('passport')
const bodyParser = require('body-parser')
const routes = require('./routes/index')
const swaggerUi = require('swagger-ui-express')
const swaggerDocument = require('./api-docs/swagger.json')

connectDB()


const app = express()

if (process.env.NODE_ENV === 'development'){
    app.use(morgan('dev'))
}
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));
app.use(passport.initialize())
require('./config/passport')(passport)
app.use(cors())
app.use(bodyParser.urlencoded({extended:true}))
app.use(bodyParser.json())
app.use(routes)


const PORT =process.nextTick.PORT || 3000
app.listen(PORT, 
    console.log(`server running in ${process.env.NODE_ENV} mode on port ${PORT}`)
)