//
//  CateAnimationLogin.h
//  MyProject
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 berchina. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ClickType){
    clicktypeNone,
    clicktypeUser,
    clicktypePass
};
@interface SNTransactionCateAnimationLogin : UIView
@property (strong, nonatomic)UITextField *userNameTextField;
@property (strong, nonatomic)UITextField *PassWordTextField;
@property (strong, nonatomic) NSString * address;

-(instancetype)initWithFrame:(CGRect)frame withAddress: (NSString *) address;
@end
