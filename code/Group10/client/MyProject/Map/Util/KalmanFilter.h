//
//  KalmanFilter.h
//  RunApp
//
//  Created by BenTsai on 2019/12/16.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#ifndef KalmanFilter_h
#define KalmanFilter_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LocationData.h"

//卡尔曼滤波器

@interface KalmanFilter : NSObject

- (void)locationUpdate:(LocationData *)locationData;
- (LocationData *)getFilteredLocationData;

@end

#endif /* KalmanFilter_h */
