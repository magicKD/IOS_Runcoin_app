var mongoose = require('../db/db.js'), 
Schema = mongoose.Schema; 
var UserSchema = new Schema({address:{type: String},//地址
publicKey: {type: String},//公钥
balance: {type: Number},//余额
});
module.exports = mongoose.model('User',UserSchema);