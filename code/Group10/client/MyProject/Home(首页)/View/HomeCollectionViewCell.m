//
//  HomeCollectionViewCell.m
//  MyProject
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 berchina. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell

- (void)awakeFromNib {
    
    self.noticeLabel.layer.cornerRadius = 4;
    self.noticeLabel.layer.masksToBounds = YES;
    self.noticeLabel.layer.borderWidth = 1;
    self.noticeLabel.layer.borderColor = self.noticeLabel.textColor.CGColor;
    // Initialization code
}

@end
