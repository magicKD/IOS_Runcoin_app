//
//  SNUserDBManager.h
//  RunDB
//
//  Created by Ben Tsai on 2019/12/20.
//  Copyright © 2019 Student. All rights reserved.
//

#ifndef SNUserDBManager_h
#define SNUserDBManager_h

#import <Foundation/Foundation.h>
#import "SNUserModel.h"
#import "FMDatabase.h"

@interface SNUserDBManager : NSObject
    
+ (SNUserDBManager *)getInstance;//单例模式，获得全局DB管理器
- (SNUserModel*) Login:(NSString*)username Password:(NSString*)password;
- (bool) createUser:(SNUserModel*)user;

@end
#endif /* SNUserDBManager_h */
