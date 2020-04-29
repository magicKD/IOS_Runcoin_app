//
//  AppDelegate.h
//  MyProject
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 berchina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfomation.h"
#import "SNUserDBManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *arrayForCart;

@property (strong ,nonatomic) UserInfomation *userInfomation;
@property (assign, nonatomic) BOOL userHasLogin;

@property (strong, nonatomic) SNUserModel * curUser;

@property (strong, nonatomic) UIWebView * webView;

@end

