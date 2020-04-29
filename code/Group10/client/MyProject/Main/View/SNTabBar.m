//
//  SNTabBar.m
//  MyProject
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 berchina. All rights reserved.
//

#import "SNTabBar.h"
#import "SNButton.h"
@interface SNTabBar()
@property (nonatomic,strong) UIButton *plusBtn;
@end

@implementation SNTabBar



-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        SNButton *plusBtn = [SNButton buttonWithType:UIButtonTypeCustom];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
        [plusBtn setTitle:@"跑步" forState:UIControlStateNormal];
        [plusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        plusBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        plusBtn.titleEdgeInsets = UIEdgeInsetsMake(78, 0, 0, 0);
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    return self;
}
/**
 *  加号点击事件
 */
-(void)plusClick
{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}
-(void)layoutSubviews
{
    //不能删，一定要调用，等布局完我们再覆盖行为
    [super layoutSubviews];
    //覆盖排布
    
    //1.设置自定义按钮的位置
    self.plusBtn.centerX = self.width*0.5;
    self.plusBtn.y = -25;
    
    
    //2.设置其他tabbarButton的位置和尺寸
    CGFloat tabbarButtonW = self.width/5;
    CGFloat tabbarButtonIndex = 0;
    
    for (UIView *child in self.subviews) {
        Class class =  NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            //设置宽度
            child.width = tabbarButtonW;
            //设置x
            child.x = tabbarButtonIndex*tabbarButtonW;
            
            //增加索引
            tabbarButtonIndex++;
            if (tabbarButtonIndex == 2) {
                tabbarButtonIndex++;
            }
        }
    }
}

@end
