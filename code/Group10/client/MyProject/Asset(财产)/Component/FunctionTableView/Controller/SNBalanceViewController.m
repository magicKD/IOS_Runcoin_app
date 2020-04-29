//
//  SNBalanceViewController.m
//  MyProject
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 berchina. All rights reserved.
//

#import "SNBalanceViewController.h"
#import "../View/SDYuEBaoTableViewCellContentView.h"

#import "SNNetworkManager.h"
#import "AppDelegate.h"

@interface SNBalanceViewController ()

@end

@implementation SNBalanceViewController{
    AppDelegate * delegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    // Do any additional setup after loading the view.
    SDYuEBaoTableViewCellContentView * view = [[SDYuEBaoTableViewCellContentView alloc] init];
    AFHTTPSessionManager * manager = [SNNetworkManager getInstance].manager;
    NSDictionary * dict = @{
                            @"address": delegate.curUser.address
                            };
    NSString *url = @"http://127.0.0.1:8080/balance";
    [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject){
//            view.totalMoneyAmount = (float)(responseObject[@"balance"]);
//            view.yesterdayIncome = view.totalMoneyAmount / 10;
            NSString * str = responseObject[@"balance"];
            float amount = [str floatValue];
            view.totalMoneyAmount = amount;
            view.yesterdayIncome = amount / 10;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"network error:%@", error);
    }];
//    view.totalMoneyAmount = 100;
//    view.yesterdayIncome = 26;
    [self.view addSubview:view];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
