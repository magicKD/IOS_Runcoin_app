//
//  SNTimeManager.h
//  RunApp
//
//  Created by BenTsai on 2019/12/16.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#ifndef SNTimeManager_h
#define SNTimeManager_h

//计时器
#import <Foundation/Foundation.h>

@protocol SNTimeManagerDelegate <NSObject>

- (void)tickWithAccumulatedTime:(NSUInteger)time;

@end

@interface SNTimeManager : NSObject

@property (nonatomic, weak) id<SNTimeManagerDelegate> delegate;

- (void)start;
- (void)pause;
//- (void)stop;
- (NSUInteger)getTotalTime;
- (NSUInteger)currentAccumulatedTime;

@end

#endif /* SNTimeManager_h */
