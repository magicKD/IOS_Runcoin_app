var express = require('express');
var router = express.Router();
var EthCrypto = require("eth-crypto");
var userManager = require('../manager/userManager.js')
var transactionManager = require('../manager/transactionManager.js');


//输入发起交易的地址，信息和签名，返回是否通过验证
function checkSignature(address, message, signature){
    var signer = EthCrypto.recover(signature, EthCrypto.hash.keccak256(message));
    console.log(signer);
    return address == signer;
}
//无特殊说明，参数都是String类型

/**
 * 逻辑：添加到数据库中
 * post参数:{
 *  address
 *  publicKey
 * }
 * return参数:{
 *  message
 * }
 */
router.post("/register", function(req, res){
    console.log(req.body);
    userManager.createUser(req.body.address, req.body.publicKey).then(function (result) {
        if(result==false){
            res.status(400);
            res.json({
            message: "failed"
            });
        }else{
            res.status(200);
             res.json({
            message: "success"
            });
        }
    }).catch(function (err) {
        console.log(err); //error捕获在这里
        res.status(500);
        res.json({ "err": err });
    });
});

/**
 * 逻辑：返回账号对应的金额
 * post参数{
 *  address
 * }
 * return参数{
 *  balance String
 * }
 */
router.post("/balance", function(req, res){
    userManager.getUserBalance(req.body.address).then(function (result) {
            res.status(200);
             res.json({
            balance: String(result)
            });
    }).catch(function (err) {
        console.log(err); //error捕获在这里
        res.status(500);
        res.json({ "err": err });
    });
});

/**
 * 逻辑：转账操作
 * post 参数{
 *  curAddress,
 *  toAddress,
 *  amount,
 *  dateStr,
 *  signature // curAddress+dateStr
 * }
 * return 参数{
 *  message:"success" or "fail"
 * }
 */
router.post("/transfer", function(req, res){
    console.log(req.body);
    var curAddress = req.body.curAddress;
    var toAddress = req.body.toAddress;
    var amount = req.body.amount;
    var dateStr = req.body.dateStr;
    var signature = req.body.signature;
    var message = curAddress + "+" + dateStr;
    if (checkSignature(curAddress, message, signature)){
        //业务处理
        res.json({
            message: "success"
        });
        userManager.getUserBalance(curAddress).then(function (result) {
            if(result<amount){
                res.status(400);
                res.json({
                message: "not enough money"
                });
            }else{
                userManager.withdrawUserBalance(curAddress,amount).then(function(result){
                    userManager.addUserBalance(toAddress,amount).then(function(result){
                        res.status(200);
                         res.json({
                        message: "success"
                        });
                    });
                });
            }
        }).catch(function (err) {
            console.log(err); //error捕获在这里
            res.status(500);
            res.json({ "err": err });
        });
    }
    else{
        res.json({
            message: "fail"
        });
    }
});

router.get('/get', function (req, res, next) {
    transactionManager.getAllTransactions().then(function (result) {
        res.json({ "result": result });
    }).catch(function (err) {
        console.log(err); //error捕获在这里
        res.json({ "err": err });
    });

});

router.post('/cr', function (req, res, next) {
    transactionManager.createTransaction(req.body.address,"", req.body.amount, req.body.info, req.body.img).then(function (result) {
        res.json({ "result": result });
    }).catch(function (err) {
        console.log(err); //error捕获在这里
        res.json({ "err": err });
    });

});

module.exports = router;