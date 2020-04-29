var mongoose = require('../db/db.js'), 
Schema = mongoose.Schema; 
var TransactionSchema = new Schema({buyer_address:{type: String},//买家地址
buyer_publicKey:{type: String},//买家公钥
seller_address:{type: String},//卖家地址
seller_publicKey:{type: String},//卖家公钥
amount: {type: Number},//价格
info : {type: String}, //信息
img : {type:String},
date : {type:String}
});
module.exports = mongoose.model('Transaction',TransactionSchema);