//
//  SNTimeFunc.h
//  RunApp
//
//  Created by BenTsai on 2019/12/16.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNTimeFunc : NSObject

+ (NSString *)timeStrFromUseTime:(NSInteger)useTime;
+ (NSString *)dateStrFromTimestamp:(NSInteger)timestamp;

@end
