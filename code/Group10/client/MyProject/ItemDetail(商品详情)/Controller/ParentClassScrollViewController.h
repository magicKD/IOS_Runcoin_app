//
//  ParentClassScrollViewController.h
//  MyProject
//
//  Created by apple on 2019/12/18.
//  Copyright © 2019 berchina. All rights reserved.
//

#import "ParentClassScrollViewController.h"
@protocol scrollDelegate <NSObject>
-(void)scrollViewLeaveAtTheTop:(UIScrollView *)scrollView;
-(void)scrollViewChangeTab:(UIScrollView *)scrollView;
-(void)scrollviewhuadong; // 所有页面 里面的滑动时间
-(void)Urlimg:(NSString *)string; //  酒仓 头部图片
-(void)readfreachframe;  // 酒仓 刷新的时候-刷新数据，不可滑动页面
-(void)puchDeatileindex;// 在购买记录没有数据的情况下，去热门推荐

@end


@interface ParentClassScrollViewController : UIViewController
@property(nonatomic,weak)id<scrollDelegate>delegate;
@end
