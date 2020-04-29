//
//  SNTimeManager.m
//  RunApp
//
//  Created by BenTsai on 2019/12/17.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#import "SNTimeManager.h"

//计时器
@interface SNTimeManager ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSUInteger startTime; // 时间记录单位全为“秒”
@property (nonatomic, assign) NSUInteger totalTime;
@property (nonatomic, assign) NSUInteger pauseAccumulatedTime;  // 暂停累加的时间

@end

@implementation SNTimeManager

- (id)init
{
    self = [super init];
    if (self)
    {
        self.startTime = 0;
        self.totalTime = 0;
        self.pauseAccumulatedTime = 0;
    }
    
    return self;
}

- (void)start
{
    self.startTime = (NSUInteger)CFAbsoluteTimeGetCurrent();
    
    self.timer = [NSTimer timerWithTimeInterval:0.2
                                         target:self
                                       selector:@selector(clockTick:)
                                       userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)pause
{
    if (self.timer)
    {
        [self.timer invalidate];
        self.timer = nil;
        
        NSUInteger currentTime = (NSUInteger)CFAbsoluteTimeGetCurrent();
        NSUInteger elapsedTime = currentTime - self.startTime;
        self.pauseAccumulatedTime += elapsedTime;
    }
}

- (void)clockTick:(NSTimer *)timer
{
    NSUInteger currentAccumulateTime = [self currentAccumulatedTime];
    [self.delegate tickWithAccumulatedTime:currentAccumulateTime];
}

- (NSUInteger)currentAccumulatedTime
{
    if (!self.startTime)
    {
        return 0;
    }
    
    NSUInteger currentTime = (NSUInteger)CFAbsoluteTimeGetCurrent();
    NSUInteger elapsedTime = currentTime - self.startTime;
    
    NSUInteger accumulatedTime = self.pauseAccumulatedTime + elapsedTime;
    return accumulatedTime;
}

- (NSUInteger)getTotalTime
{
    return self.pauseAccumulatedTime;
}

@end
