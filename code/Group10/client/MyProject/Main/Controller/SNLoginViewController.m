//
//  SNLoginViewController.m
//  MyProject
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 berchina. All rights reserved.
//

#import "SNLoginViewController.h"

@interface SNLoginViewController ()

@end

@implementation SNLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self changeNav];
    // Do any additional setup after loading the view from its nib.
}

-(void)changeNav
{
    self.navigationItem.title = @"支付宝账号登录";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem CreateItemWithTarget:self ForAction:@selector(back) WithImage:@"close_icon" WithHighlightImage:@"close_icon_highlighted"];
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
