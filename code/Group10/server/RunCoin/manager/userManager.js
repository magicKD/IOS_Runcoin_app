			var User = require("../model/userModel.js");

			var userManager = {
			//注册用户
				isUserExisted: function(address){
					return new Promise(function(resolve, reject) {
					var wherestr = {'address' : address};
					User.find(wherestr, function(err, res){ 
						if(err){ 
							console.log("Error:" + err); 
							resolve(false);
						}else{
							if(res.length==0) resolve(false);
							resolve(true);
						}
					});
					});
				},
			    createUser:function (address,publicKey) {
			    		var um = this;
			    		return new Promise(function(resolve,reject){
			    			um.isUserExisted(address).then(function(result){
			    				if (result==true) {resolve(false);return;}
								var user = new User({address:address,publicKey:publicKey,balance:0});
								user.save(function (err, res) {
			 					if (err) { 
									console.log("Error:" + err);
									resolve(false);
			 						} else { 
									resolve(true);
									}
								}); 
								});
			    		});
			    	},
			    	
				//删除用户
			    deleteUser:function (address){
			    	return new Promise(function(resolve, reject) {
					var wherestr = {'address' : address}; User.remove(wherestr, function(err, res){ 
					if (err) { 
						console.log("Error:" + err);
						resolve(false); 
					} else { 
						resolve(true);
					} 
					});
					});
				},

			//获得用户余额
			    getUserBalance:function (address){
			    	return new Promise(function(resolve, reject) {
			    		var wherestr = {'address' : address}; 
						User.find(wherestr, function(err, res){ 
						if (err) { 
							console.log("Error:" + err); 
							resolve(-1);
						} else { 
							if(res.length==0) resolve(-1);
							else resolve(res[0].balance);
						} 
			    	});
				}); 

			},

			//增加用户余额
			addUserBalance:function (address,add_amount){
				var um = this;
				return new Promise(function(resolve, reject) {
					um.getUserBalance(address).then(function(balance){
						if(balance<0) {resolve(false);return;} //账户不存在
						var wherestr = {'address' : address}; 
						var new_balance = balance + add_amount;
						var updatestr = {'balance': new_balance};
						User.update(wherestr, updatestr, function(err, res){ 
							if (err) { 
								console.log("Error:" + err); 
								resolve(false);
							} else { 
								resolve(true)
							}}); 
					});
				});
			},

			//减少用户余额
			withdrawUserBalance:function (address,decrease_amount){
				var um = this;
				return new Promise(function(resolve, reject) {
					um.getUserBalance(address).then(function(balance){
						if(balance<0) {resolve(false);return;}  //账户不存在
						var wherestr = {'address' : address}; 
						var new_balance = balance - decrease_amount;
						if(new_balance<0) {resolve(false);return;} //余额不足
						var updatestr = {'balance': new_balance};
						User.update(wherestr, updatestr, function(err, res){ 
							if (err) { 
								console.log("Error:" + err); 
								resolve(false);
							} else { 
								resolve(true)
							}}); 
					});
				});
			}
		};

module.exports = userManager;