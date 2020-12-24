const express = require('express')
const actions = require('../methods/actions')

const router = express.Router()

//@desc add new user
//@route get /
router.get('/', (req,res)=>{
    res.send('hello')
})


// @desc add new user
// @route POST /assNewUser
router.post('/addNewUser', actions.addNewUser)

// @desc auth user
// @router POST /authUser
router.post('/authUser', actions.authUser)

// @desc check token
// @router get check token
router.get('/getInfo', actions.getInfo)


module.exports = router