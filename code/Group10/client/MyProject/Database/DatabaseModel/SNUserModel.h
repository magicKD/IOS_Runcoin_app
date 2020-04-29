//
//  SNUserModel.h
//  RunDB
//
//  Created by Ben Tsai on 2019/12/20.
//  Copyright © 2019 Student. All rights reserved.
//

#ifndef SNUserModel_h
#define SNUserModel_h
#import <Foundation/Foundation.h>

@interface SNUserModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *privateKey;
@property (nonatomic, copy) NSString *publicKey;
@property (nonatomic, copy) NSString *address;

- (NSString *)description;

@end

#endif /* SNUserModel_h */

