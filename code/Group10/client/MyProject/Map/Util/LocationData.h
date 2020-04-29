//
//  LocationData.h
//  RunApp
//
//  Created by BenTsai on 2019/12/16.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#ifndef LocationData_h
#define LocationData_h

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>

@interface LocationData : NSObject

- (id)initWithLatitude:(double)latitude
             longitude:(double)longitude
                 speed:(CGFloat)speed
             timestamp:(NSInteger)timestamp;
- (CLLocationCoordinate2D)getCoordinate;

- (double)getLatitude;
- (double)getLongitude;
- (CGFloat)getSpeed;
- (NSInteger)getTimestamp;
- (double)getAccuracy;

@end
#endif /* LocationData_h */
