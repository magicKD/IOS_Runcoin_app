//
//  DetaImagetableViewCell.h
//  MyProject
//
//  Created by apple on 2019/12/18.
//  Copyright © 2019 berchina. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsModel;
@interface DetaImagetableViewCell : UITableViewCell
@property(nonatomic,strong)GoodsModel *model;
@property(nonatomic,strong)UIImageView *image;
+(instancetype)WithDetaImagetableViewCell:(UITableView *)tableview;
@end
