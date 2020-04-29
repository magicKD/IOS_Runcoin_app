//
//  SDYuEBaoTableViewCellContentView.h
//  MyProject
//
//  Created by apple on 2019/12/18.
//  Copyright © 2019 berchina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDYuEBaoTableViewCellContentView : UIView

@property (nonatomic, assign) float yesterdayIncome;
@property (nonatomic, assign) float totalMoneyAmount;

@property (weak, nonatomic) IBOutlet UILabel *yesterdayIncomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyAmountLabel;

@end
