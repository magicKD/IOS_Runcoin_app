//
//  MacroDefine.h
//  MyProject
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 berchina. All rights reserved.
//

#ifndef MacroDefine_h
#define MacroDefine_h


//颜色
#define SNColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//黄色导航栏 DeepSkyBlue
#define NavBarColor SNColor(250,227,111)
//#define NavBarColor SNColor(0,191,255)
#define GrayBarColor SNColor(240,240,240)

#define BackgroundColor SNColor(233,233,233)
//定位颜色
#define LocateColor SNColor(61,181,230)

//尺寸
#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height
#define TabBarHeight 49

#endif /* MacroDefine_h */
