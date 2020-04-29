//
//  ViewTool.m
//  MyProject
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 berchina. All rights reserved.
//

#import "SNViewTool.h"

@implementation SNViewTool
#pragma mark 给视图添加细线
+ (void)setLineFatherView:(UIView*)view lineFrame:(CGRect)rect lineColor:(UIColor*)color
{
    UILabel *lineLab = [[UILabel alloc] initWithFrame:rect];
    lineLab.backgroundColor = color;
    [view sendSubviewToBack:lineLab];
    [view addSubview:lineLab];
}
@end
