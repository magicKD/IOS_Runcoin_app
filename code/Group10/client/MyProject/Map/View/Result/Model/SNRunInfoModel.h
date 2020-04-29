//
//  SNRunInfoModel.h
//  RunApp
//
//  Created by BenTsai on 2019/12/16.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

@interface SNRunInfoModel : NSObject

// 跑步的开始时间，结束时间，用时。单位为秒，timeIntervalSince1970
@property (nonatomic, assign) NSInteger beginTime;
@property (nonatomic, assign) NSInteger endTime;
@property (nonatomic, assign) NSInteger useTime;

@property (nonatomic, copy) NSDate *date;     // 此次跑步的日期

@property (nonatomic, assign) CGFloat hSpeed;   // 最快速度
@property (nonatomic, assign) CGFloat lSpeed;   // 最低速度
@property (nonatomic, assign) CGFloat speed;    // 平均速度
@property (nonatomic, assign) CGFloat pace;     // 配速

@property (nonatomic, assign) CGFloat distance;     // 跑步总距离，单位：米
@property (nonatomic, copy) NSString *uid;      // 对应user

@property (nonatomic, copy) NSArray *locationArray;     // 保存定位坐标数据
@property (nonatomic, weak) MAMapView *mapView;

@end
