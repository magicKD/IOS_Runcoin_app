//
//  SNMapProcesser.h
//  RunApp
//
//  Created by BenTsai on 2019/12/16.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#ifndef SNMapProcessFunc_h
#define SNMapProcessFunc_h

//用于被MapViewController调用以用滤波处理坐标点数组

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import "KalmanFilter.h"
#import "LocationData.h"

@interface SNMapProcesser : NSObject

- (CLLocationCoordinate2D)processWithCoordinate:(CLLocationCoordinate2D)coordinate speed:(CGFloat)speed timestamp:(NSInteger)timestamp;

@end

#endif /* SNMapProcessFunc_h */
