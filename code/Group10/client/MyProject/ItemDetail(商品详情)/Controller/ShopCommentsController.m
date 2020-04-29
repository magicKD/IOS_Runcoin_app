//
//  ShopCommentsController.m
//  MyProject
//
//  Created by apple on 2019/12/18.
//  Copyright © 2019 berchina. All rights reserved.
//

#import "ShopCommentsController.h"

@interface ShopCommentsController ()<UITableViewDataSource,UITableViewDelegate>
{
    int heightDict;
}
@property(nonatomic,strong)NSMutableArray *imagearr;


@end

@implementation ShopCommentsController
-(UITableView *)tableview{
    if (_tableview==nil) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-60-Heightscrooler-SafeAreaTopHeight) style:UITableViewStylePlain];
        _tableview.showsVerticalScrollIndicator=NO;
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableview.bounces=YES;
        _tableview.dataSource=self;
        _tableview.delegate=self;
        [self.view addSubview:_tableview];
    }
    return _tableview;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetaImagetableViewCell *cell=[DetaImagetableViewCell WithDetaImagetableViewCell:tableView];
    cell.image.tag=indexPath.row;
    return cell;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _imagearr=@[].mutableCopy;
    [self tableview];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置文字
    [header setTitle:@"释放查看商品信息!" forState:MJRefreshStateIdle];
    [header setTitle:@"释放查看商品信息!" forState:MJRefreshStatePulling];
    [header setTitle:@"释放查看商品信息!"  forState:MJRefreshStateRefreshing];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    // 设置刷新控件
    self.tableview.header = header;
    
}
-(void)loadNewData{
    
    [self.tableview.header endRefreshing];
    [UIView animateWithDuration:1 animations:^{
        [self.delegate scrollviewhuadong];
    }];
    
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
