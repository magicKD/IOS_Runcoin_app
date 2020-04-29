//
//  SNEthCrypto.h
//  MyProject
//
//  Created by apple on 2019/12/20.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SNUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SNEthCrypto : NSObject

//利用私钥对信息进行签名
- (NSString *) sign:(NSString * ) privateKey withMessage:(NSString *) message;

//Recovers the signers address from the signature.
- (NSString *) recover:(NSString *) signature withMessage:(NSString *) message;

//生成新的账号
- (NSDictionary *) createIdentity;

//单例模式
+ (instancetype) getInstance;

//签名可能用到的函数
- (NSString *) getCurrentDateStr;

//签上自己的地址+时间戳
- (NSString *) getSignatureWithAddressAndTimestamp:(SNUserModel *) curUser;

- (NSString *) getSignatureWithUser:(SNUserModel *) curUser withTimestamp:(NSString *) dateStr;

@end

NS_ASSUME_NONNULL_END
