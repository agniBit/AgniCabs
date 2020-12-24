var User = require('../models/user')
var jwt = require('jwt-simple')
var config = require('../config/dbconfig')
const { ConnectionStates } = require('mongoose')
var functions = {
    addNewUser: function(req, res) {
        if ((!req.body.name) ||(!req.body.password)||(!req.body.username)) {
            res.status(400).json({success:false, msg: 'enter username and password'})
        }
        else{
            var newUser = User({
                name: req.body.name,
                password: req.body.password,
                email: req.body.email,
                username: req.body.username
            });
            newUser.save( function (err, newUser) {
                if (err) {
                    res.status(500).json({success:false, msg: 'Failed to save'})
                }
                else {
                    res.status(200).json({success:true, msg: 'successfully add user'})
                }
            })
        }
    },
    authUser: function(req,res) {
        User.findOne({
            username: req.body.username
        }, function (err,user) {
            if (err) throw err
            if(!user) {
                res.status(403).send({success: false, msg:'user not found'})
            }
            else {
                user.comparePassword(req.body.password, function (err, isMatch) {
                    if (isMatch && !err) {
                        var token = jwt.encode(user, config.secret)
                        return res.json({success: true, token: token})
                    }
                    else {
                        return res.status(403).send({success: false, msg: "Authentication failed try again"})
                    }
                })
            }
        })
    },
    getInfo: function (req, res) {
        if( req.headers.authorization 
            && req.headers.authorization.split(' ')[0]==='Bearer') {
                var token = req.headers.authorization.split(' ')[1]
                var decodedToken = jwt.decode(token, config.secret)
                return res.json({success: true,msg: decodedToken.name})
        }
        else{
            return res.json({success: false,msg: 'no header'})
        }
    }
}

module.exports = functions