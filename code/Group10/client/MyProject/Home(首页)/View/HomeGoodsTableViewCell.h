//
//  HomeGoodsTableViewCell.h
//  MyProject
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 berchina. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeGoodsFrame;
@interface HomeGoodsTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) HomeGoodsFrame *goodFrame;
@end
