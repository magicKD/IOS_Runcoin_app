//
//  SNMapAnnotation.h
//  RunApp
//
//  Created by BenTsai on 2019/12/16.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

//由于NSArray无法放入C语言定义的CLLocationCoordinate2D结构，这里需做一层封装

#ifndef SNMapCoordinate_h
#define SNMapCoordinate_h

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>


@interface SNMapAnnotation : NSObject <MAAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end

#endif /* SNMapCoordinate_h */
