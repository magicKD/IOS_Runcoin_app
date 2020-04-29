//
//  SLPayViewController.h
//  MyProject
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 berchina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNGoodsDetail.h"
#import "AppDelegate.h"

@interface SLPayViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    AppDelegate *delegate;
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) SNGoodsDetail *goodsYouPayNow;
@property (weak, nonatomic) IBOutlet UILabel *labelPayMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelPhone;


- (IBAction)viewBackAction:(UIBarButtonItem *)sender;
- (IBAction)payMoneyAction:(UIButton *)sender;


@end
