//
//  HomeGoodsModel.h
//  MyProject
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 berchina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeGoodsModel : NSObject
@property (nonatomic,copy) NSString *nickName;
@property (nonatomic,assign) NSUInteger level;
@property (nonatomic,copy) NSString *addTime;
@property (nonatomic,copy) NSString *headIcon;
@property (nonatomic,copy) NSString *realPrice;
@property (nonatomic,copy) NSString *orignPrice;
@property (nonatomic,copy) NSArray *pics;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *location;
@end
