var Transaction = require("../model/transactionModel.js");
var userManager = require('./userManager.js');

var transactiorManager = {
	createTransaction: function (seller_address, seller_publicKey, amount, info,img) {
		return new Promise(function (resolve, reject) {
			var transaction = new Transaction({seller_address : seller_address, seller_publicKey: seller_publicKey, amount: amount, info: info,img:img,date:Date.now().toString()});
			transaction.save(function (err, res) {
				if (err) {
					console.log("Error:" + err);
					resolve(false);
				} else {
					resolve(true);
				}
			});
		});
	},
	getAllTransactions: function () {
		return new Promise(function (resolve, reject) {
			Transaction.find({}, function (err, res) {
				if (err) {
					console.log("Error:" + err);
					resolve(null);
				} else {
					resolve(res);
				}
			});
		});
	},
	getSellTransactions: function (seller_address) {
		return new Promise(function (resolve, reject) {
			Transaction.find({seller_address:seller_address}, function (err, res) {
				if (err) {
					console.log("Error:" + err);
					resolve(null);
				} else {
					resolve(res);
				}
			});
		});
	},
	getBuyTransactions: function (buyer_address) {
		return new Promise(function (resolve, reject) {
			Transaction.find({buyer_address:buyer_address}, function (err, res) {
				if (err) {
					console.log("Error:" + err);
					resolve(null);
				} else {
					resolve(res);
				}
			});
		});
	},
}

module.exports = transactiorManager;