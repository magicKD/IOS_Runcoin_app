//
//  UserInfomation.h
//  MyProject
//
//  Created by apple on 2019/12/19.
//  Copyright © 2019 berchina. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfomation : NSObject

@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *password;
@property (copy, nonatomic) NSString *sex;
@property (copy, nonatomic) NSString *birthday;
@property (copy, nonatomic) NSString *imageName;

@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * publicKey;
@property (nonatomic, strong) NSString * privateKey;

@end

NS_ASSUME_NONNULL_END
