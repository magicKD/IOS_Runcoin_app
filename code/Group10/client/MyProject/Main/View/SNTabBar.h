//
//  SNTabBar.h
//  MyProject
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 berchina. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SNTabBar;

@protocol SNTabBarDelegate <UITabBarDelegate>
@optional
-(void)tabBarDidClickPlusButton:(SNTabBar *)tabBar;
@end

@interface SNTabBar : UITabBar
@property (nonatomic,weak) id<SNTabBarDelegate> delegate;
@end
