//
//  SNFunctionTableViewController.m
//  MyProject
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 berchina. All rights reserved.
//

#import "SNFunctionTableViewController.h"
#import "SNMineTableViewController.h"
#import "SNSettingTableViewController.h"
#import "SNLoginViewController.h"
#import "SNNavigationController.h"

#import "SNBalanceViewController.h"
#import "TransactionViewController.h"
#import "LoginViewController.h"

#import "AppDelegate.h"

static CGFloat FirstCellHeight = 100;
static CGFloat CellHeight = 44;

@interface SNFunctionTableViewController ()
@property (nonatomic,strong) NSArray *listArray;
@property (nonatomic,strong) NSArray *imageArray;
@end

@implementation SNFunctionTableViewController{
    AppDelegate * delegate;
}

-(NSArray *)listArray
{
    if (!_listArray) {
        self.listArray = @[@[@"资产详情"],@[@"账单"],@[@"转账"]];
        self.imageArray = @[@[@"avatar_placehold"],@[@"icon_account_selling"],@[@"icon_account_sold",@"icon_account_buy"]];
    }
    return _listArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeNav];
    delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
}

-(void)changeNav
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:NavBarColor] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
        case 2:
            return 1;
        case 3:
            return 1;
        default:
            return 0;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MINECELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MINECELL"];
        cell.textLabel.font =[UIFont systemFontOfSize:14];
    }
    cell.textLabel.text = self.listArray[indexPath.section][indexPath.row];
    [cell.imageView setImage:[UIImage imageNamed:self.imageArray[indexPath.section][indexPath.row]]];
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [SNViewTool setLineFatherView:cell lineFrame:CGRectMake(0,CellHeight-1, SCREEN_WIDTH, 1) lineColor:BackgroundColor];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc] init];
    [footView setBackgroundColor:BackgroundColor];
    return footView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        case 1:
        case 2:
        case 3:
            return CellHeight;
        default:
            return 0;
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
    
    if (indexPath.section == 0){
        SNBalanceViewController * balanceVC = [[SNBalanceViewController alloc] init];
        [self.navigationController pushViewController:balanceVC animated:YES];
    }
    else if (indexPath.section == 2){
        TransactionViewController * transactionVC = [[TransactionViewController alloc] init];
        SNNavigationController *nav = [[SNNavigationController alloc] initWithRootViewController:transactionVC];
        [self presentViewController:nav animated:YES completion:nil];
//        [self.navigationController pushViewController:transactionVC animated:YES];
    }
    else{
        SNSettingTableViewController *settingVC = [[SNSettingTableViewController alloc] init];
        [self.navigationController pushViewController:settingVC animated:YES];
    }
}



@end
