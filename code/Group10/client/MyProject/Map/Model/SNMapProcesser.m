//
//  SNMapProcesser.m
//  RunApp
//
//  Created by BenTsai on 2019/12/16.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#import "SNMapProcesser.h"


@interface SNMapProcesser ()

@property (nonatomic, strong) KalmanFilter *kalmanFilter;

@end

@implementation SNMapProcesser

- (id)init
{
    self = [super init];
    if (self)
    {
        self.kalmanFilter = [KalmanFilter new];
    }
    
    return self;
}

- (CLLocationCoordinate2D)processWithCoordinate:(CLLocationCoordinate2D)coordinate speed:(CGFloat)speed timestamp:(NSInteger)timestamp
{
    // 将坐标通过卡尔曼滤波算法处理后返回
    LocationData *locationData = [[LocationData alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude speed:speed timestamp:timestamp];
    [self.kalmanFilter locationUpdate:locationData];
    
    LocationData *filteredData = [self.kalmanFilter getFilteredLocationData];
    CLLocationCoordinate2D filterdCoordinate = [filteredData getCoordinate];
    
    return filterdCoordinate;
}

@end
