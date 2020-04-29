//
//  SNTabBarViewController.m
//  MyProject
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 berchina. All rights reserved.
//

#import "SNTabBarViewController.h"
#import "SNMineTableViewController.h"
#import "SNDiscoverTableViewController.h"
#import "SNHomeTableViewController.h"
#import "SNNoticeTableViewController.h"
#import "SNSellerViewController.h"
#import "SNNavigationController.h"
#import "SNTabBar.h"
#import "SNAssetViewController.h"

#import "SNSellerViewController.h"
#import "SNRunningViewController.h"
#import "AppDelegate.h"

#import "LoginViewController.h"


@interface SNTabBarViewController ()<SNTabBarDelegate>

@end

@implementation SNTabBarViewController{
    UIViewController * homeVC;
    AppDelegate * delegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    SNHomeTableViewController *home = [[SNHomeTableViewController alloc] init];
    homeVC = home;
    [self createChildVCWithVC:home Title:@"首页" Image:@"home_normal" SelectedImage:@"home_highlight"];
    
    //    SNDiscoverTableViewController *discover = [[SNDiscoverTableViewController alloc] init];
    SNSellerViewController * sellview = [[SNSellerViewController alloc] init];
    [self createChildVCWithVC:sellview Title:@"发布" Image:@"mycity_normal" SelectedImage:@"mycity_highlight"];
    
    //    SNNoticeTableViewController *message = [[SNNoticeTableViewController alloc] init];
    //    [self createChildVCWithVC:message Title:@"消息" Image:@"message_normal" SelectedImage:@"message_highlight"];
    SNAssetViewController * assetView = [[SNAssetViewController alloc] init];
    [self createChildVCWithVC:assetView Title:@"财产" Image:@"message_normal" SelectedImage:@"message_highlight"];
    
    SNMineTableViewController *profile = [[SNMineTableViewController alloc] init];
    [self createChildVCWithVC:profile Title:@"我的" Image:@"account_normal" SelectedImage:@"account_highlight"];
    
    SNTabBar *tabBar = [[SNTabBar alloc] init];
    tabBar.delegate = self;
    [[SNTabBar appearance] setShadowImage:[[UIImage alloc] init]];
    [self setValue:tabBar forKey:@"tabBar"];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUInteger count = self.tabBar.subviews.count;
    for (int i = 0; i<count; i++) {
        UIView *child = self.tabBar.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width = self.tabBar.width / count;
        }
    }
}

-(void)createChildVCWithVC:(UIViewController *)childVC Title:(NSString *)title Image:(NSString *)image SelectedImage:(NSString *)selectedimage
{
    //设置子控制器的文字
    // childVC.tabBarItem.title =title;
    // childVC.navigationItem.title =title;
    //等价于
    childVC.title = title;//同时设置tabbar和navigation的标题
    //设置文字的样式
    NSMutableDictionary *textAttrs = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *selectedtextAttrs = [[NSMutableDictionary alloc]init];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    selectedtextAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:selectedtextAttrs forState:UIControlStateSelected];
    //设置子控制器的图片
    childVC.tabBarItem.image =[UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedimage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //这句话的意思是声明这张图片按照原始的样子显示出来，不要自动渲染成其他颜色
    
    // childVC.view.backgroundColor = RandomColor;
    
    //给子控制器包装导航控制器
    SNNavigationController *nav = [[SNNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

#pragma mark - tabbar代理方法
-(void)tabBarDidClickPlusButton:(SNTabBar *)tabBar
{
    NSLog(@"run");
    
    if (!delegate.userHasLogin){
        [self handleUnlogin];
        return ;
    }
    
    SNRunningViewController * vc = [[SNRunningViewController alloc] init];
    //    homeVC.navigationController.navigationBarHidden = YES;
    self.selectedIndex = 0;
    homeVC.navigationController.navigationBar.hidden = YES;
    [homeVC.navigationController pushViewController:vc animated:YES];
    
    
}

-(void)takePhoto
{
    
}

-(void)takeFromAlbum
{
    
}

#pragma mark - 处理未登录逻辑
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
