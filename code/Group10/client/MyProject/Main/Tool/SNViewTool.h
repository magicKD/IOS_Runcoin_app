//
//  ViewTool.h
//  MyProject
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 berchina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNViewTool : NSObject
#pragma mark 给视图添加细线
+(void) setLineFatherView:(UIView*)view lineFrame:(CGRect)rect lineColor:(UIColor*)color;
@end
