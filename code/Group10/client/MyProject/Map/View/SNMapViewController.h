//
//  SNMapViewController.h
//  RunApp
//
//  Created by BenTsai on 2019/12/16.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#ifndef SNMapViewController_h
#define SNMapViewController_h

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

//MapView更新时的回调函数
@protocol SNMapViewDelegate <NSObject>

@required
- (void)updateDistance:(CGFloat)distance;

@end

@interface SNMapViewController : UIViewController

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, weak) id<SNMapViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *annotationRecordArray;
@property (nonatomic, strong) UILabel *testLabel;   // 显示数据的标签

- (void)setupMapView;
- (void)startLocation;
- (void)endLocation;

- (CGFloat)getHighestSpeed;
- (CGFloat)getLowestSpeed;
- (CGFloat)getTotalDistance;
- (NSArray *)getCoordinateRecord;

@end

#endif /* SNMapViewController_h */
