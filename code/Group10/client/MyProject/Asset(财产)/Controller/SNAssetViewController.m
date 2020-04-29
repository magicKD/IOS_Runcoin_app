//
//  SNAssetViewController.m
//  MyProject
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 berchina. All rights reserved.
//

#import "SNAssetViewController.h"
#import "../Scan/JMGenerateQRCodeVC.h"
#import "../Scan/JMScanningQRCodeVC.h"
#import "JMScanningQRCodeUtils.h"
#import "../Component/FunctionTableView/Controller/SNFunctionTableViewController.h"

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "SNNavigationController.h"

#define kHomeHeaderViewHeight 110
#define sn_width frame.size.width
#define sn_height frame.size.height
#define sn_y frame.origin.y
#define sn_x frame.origin.x

@interface SNAssetViewController ()

@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, strong) SNFunctionTableViewController * mainViewController;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation SNAssetViewController{
    AppDelegate * delegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor greenColor];
    delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.view.backgroundColor = [UIColor whiteColor];
    [self changeNav];
    [self setupHeader];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGFloat tabbarHeight = self.tabBarController.tabBar.sn_height;
//    [[self.tabBarController tabBar] sd_height];
    
    CGFloat headerY = 0;
    headerY = ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) ? 64 : 0;
    _headerView.frame = CGRectMake(0, headerY, self.view.sn_width, kHomeHeaderViewHeight);
    
    self.mainViewController = [[SNFunctionTableViewController alloc] init];
    [self addChildViewController:self.mainViewController];
    [self.view addSubview:self.mainViewController.view];
    
    self.mainViewController.view.frame = CGRectMake(0, _headerView.sn_y + kHomeHeaderViewHeight + 10, self.view.sn_width, self.view.sn_height - kHomeHeaderViewHeight - 50);
//    self.mainViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.mainViewController.view.topAnchor constraintEqualToAnchor:self.headerView.bottomAnchor constant:10].active=true;
}


-(void)changeNav
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:NavBarColor] forBarMetrics:UIBarMetricsDefault];
}

- (void)setupHeader
{
    UIView *header = [[UIView alloc] init];
    header.bounds = CGRectMake(0, 0, self.view.sn_width, kHomeHeaderViewHeight);
    header.backgroundColor = [UIColor colorWithRed:(38 / 255.0) green:(42 / 255.0) blue:(59 / 255.0) alpha:1];
    [self.view addSubview:header];
    _headerView = header;
    
    UIButton *scan = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, header.sn_width * 0.5, header.sn_height)];
    [scan setImage:[UIImage imageNamed:@"home_scan"] forState:UIControlStateNormal];
    [scan addTarget:self action:@selector(scanButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:scan];
    
    UIButton *pay = [[UIButton alloc] initWithFrame:CGRectMake(scan.sn_width, 0, header.sn_width * 0.5, header.sn_height)];
    [pay setImage:[UIImage imageNamed:@"home_pay"] forState:UIControlStateNormal];
    [pay addTarget:self action:@selector(payButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:pay];
}

#pragma mark - click action
- (void) payButtonClicked
{
    if (!delegate.userHasLogin){
        [self handleUnlogin];
        return ;
    }
    [self.navigationController pushViewController:[[JMGenerateQRCodeVC alloc] init]  animated:true];
}

- (void) scanButtonClicked{
    if (!delegate.userHasLogin){
        [self handleUnlogin];
        return ;
    }
    [JMScanningQRCodeUtils jm_cameraAuthStatusWithSuccess:^{
        [self.navigationController pushViewController:[[JMScanningQRCodeVC alloc] init] animated:YES];
    } failure:^{
        
    }];
}

#pragma mark - 没登录
- (void) handleUnlogin{
    if (!delegate.userHasLogin){
        //还没登陆
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户未登陆" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                   {
                                       LoginViewController *loginVC = [[LoginViewController alloc] init];
                                       SNNavigationController *nav = [[SNNavigationController alloc] initWithRootViewController:loginVC];
                                       [self presentViewController:nav animated:YES completion:nil];
                                   }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return ;
    }
}

@end
