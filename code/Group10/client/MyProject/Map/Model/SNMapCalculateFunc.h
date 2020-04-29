//
//  SNMapCalculateFunc.h
//  RunApp
//
//  Created by BenTsai on 2019/12/16.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#ifndef SNMapCalculateFunc_h
#define SNMapCalculateFunc_h

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import "SNMapAnnotation.h"

//用于被MapViewController调用以计算点距离或处理坐标点数组
//以下全为静态类方法

@interface SNMapCalculateFunc : NSObject

+ (CGFloat)distanceBetweenAnnotation1:(SNMapAnnotation *)annotation1
                          annotation2:(SNMapAnnotation *)annotation2;
+ (CGFloat)distanceBetweenCoordinate1:(CLLocationCoordinate2D)coordinate1
                          coordinate2:(CLLocationCoordinate2D)coordinate2;

+ (CGFloat)totalDistance:(NSArray<SNMapAnnotation *> *)annotationArray;
+ (CGFloat)calculateSpeedWithTime:(NSInteger)time
                  annotationArray:(NSArray<SNMapAnnotation *> *)annotationArray;

+ (void)addAnnotationArray:(NSArray<SNMapAnnotation *> *)annotationArray
                 toMapView:(MAMapView *)mapView;

+ (NSArray *)getLastObjectsFromArray:(NSArray *)fromArray
                     numberOfObjects:(NSInteger)number;

@end

#endif /* SNMapCalculateFunc_h */
