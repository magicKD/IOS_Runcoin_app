//
//  SNHomeTableViewController.m
//  MyProject
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 berchina. All rights reserved.
//

#import "SNHomeTableViewController.h"
#import "AdView.h"
#import "SNLineLayout.h"
#import "HomeCollectionViewCell.h"
#import "HomeGoodsFrame.h"
#import "HomeGoodsTableViewCell.h"
#import "HomeGoodsModel.h"

#import "DWQCommitController.h"
#import "SNSellerViewController.h"
#import "ItemDetailViewController.h"
#import "SNAnnouncementContentViewController.h"
#import <AFNetworking/AFNetworking.h>

#import "SNEthCrypto.h"

static NSString *const ID =@"collectionCell";

@interface SNHomeTableViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *YTList;
@property (nonatomic,weak) UICollectionView *collectionView;
@property (nonatomic,weak) AdView *adView;
@property (nonatomic,weak) UITableView *goodListView;
@property (nonatomic,weak) UIView *headView;

@property (nonatomic,strong) NSMutableArray *goodListFrame;
@end

@implementation SNHomeTableViewController

-(NSMutableArray *)goodListFrame
{
    if (!_goodListFrame) {
        self.goodListFrame = [NSMutableArray array];
    }
    return _goodListFrame;
}

-(NSMutableArray *)YTList
{
    if (!_YTList) {
        self.YTList = [[NSMutableArray alloc] init];
        for (int i = 1; i<=20; i++) {
            [self.YTList addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return  _YTList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self changeNav];
    [self.view setBackgroundColor:BackgroundColor];
    
    [self createHeadView];
    
    //初始化轮播图
    [self createScrollView];
    //初始化横版滚动图
    [self createLandscapeScrollView];
    
    //初始化列表
    [self createTableView];
    
    [self createLocalData];
    
    [self setupRefresh];
    
}

-(NSArray *)trendsFrameWithStatus:(NSArray *)trendsArray
{
    //将trends模型数组转化为trendsframe模型数组
    NSMutableArray *trendsFrameArray = [NSMutableArray array];
    for (HomeGoodsModel *good in trendsArray) {
        HomeGoodsFrame *f =[[HomeGoodsFrame alloc] init];
        f.goodModel = good;
        [trendsFrameArray addObject:f];
    }
    return trendsFrameArray;
}

-(void)createLocalData
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSString *url = @"http://127.0.0.1:8080/get";
    [manger GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *arr = [NSMutableArray array];
        NSDictionary * dic = (NSDictionary*) responseObject;
        for (int i=[dic[@"result"] count]-1;i>0;i--){
            NSDictionary * tx = dic[@"result"][i];
            HomeGoodsModel *goodModel = [[HomeGoodsModel alloc] init];
            goodModel.nickName = tx[@"seller_address"];
            goodModel.addTime = tx[@"date"];
            goodModel.headIcon = @"";
            goodModel.realPrice = [NSString stringWithFormat:@"%d",(int)[tx[@"amount"] floatValue]*2];
            goodModel.orignPrice = [NSString stringWithFormat:@"%@",tx[@"amount"]];
            goodModel.pics = @[@"",@"",@""];
            goodModel.content = tx[@"info"];
            goodModel.location = @"Run Coin Chain";
            [arr addObject:goodModel];
        }
        NSArray *trendsFrame = [self trendsFrameWithStatus:arr];
        [self.goodListFrame addObjectsFromArray:trendsFrame];
        [self.goodListView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    /*NSArray *trendsFrame = [self trendsFrameWithStatus:arr];
    [self.goodListFrame addObjectsFromArray:trendsFrame];*/
}

-(void)createHeadView
{
    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 230+SCREEN_WIDTH/2);
    headView.backgroundColor = BackgroundColor;
    [self.view addSubview:headView];
    self.headView = headView;
}

-(void)createTableView
{
    UITableView *goodsListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,SCREEN_HEIGHT-49) style:UITableViewStylePlain];
    goodsListTableView.backgroundColor = BackgroundColor;
    goodsListTableView.delegate = self;
    goodsListTableView.dataSource = self;
    goodsListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    goodsListTableView.showsVerticalScrollIndicator = NO;
    self.goodListView = goodsListTableView;
    [self.view addSubview:goodsListTableView];
    
    goodsListTableView.tableHeaderView = self.headView;
}

-(void)createLandscapeScrollView
{
    CGFloat w = self.view.bounds.size.width;
    CGRect frame = CGRectMake(0,CGRectGetMaxY(self.adView.frame), w, 230);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:[[SNLineLayout alloc] init]];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = BackgroundColor;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.headView addSubview:collectionView];
    self.collectionView = collectionView;
}

-(void)createScrollView
{
    NSArray *imagesURL = @[
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576663266368&di=3d5427510760506e341c31ad5c998955&imgtype=0&src=http%3A%2F%2Fmedia.wepg.online%2Fpublic%2Fimages%2Fuser_1423%2F1525791348_913.jpeg",
//                           @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576663863166&di=8e6fff86d9a56e8acbe5a095ba9317b2&imgtype=0&src=http%3A%2F%2Fku.90sjimg.com%2Felement_origin_min_pic%2F18%2F04%2F06%2F30936d9fae7a11a8d0b6fdddccf0ee26.jpg"
                           ];
    AdView *AdScrollView = [AdView adScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2)
                              imageLinkURL:imagesURL
                    placeHoderImageName:@"page_loading_fish"
                      pageControlShowStyle:UIPageControlShowStyleCenter];
    
    //    是否需要支持定时循环滚动，默认为YES
        AdScrollView.isNeedCycleRoll = YES;

    //    设置图片滚动时间,默认3s
        AdScrollView.adMoveTime = 3.0;
    
    //图片被点击后回调的方法
    AdScrollView.callBack = ^(NSInteger index,NSString * imageURL)
    {
        NSLog(@"被点中图片的索引:%ld---地址:%@",index,imageURL);
    };
    [self.headView addSubview:AdScrollView];
    self.adView = AdScrollView;

}

-(void)setupRefresh
{
    SNRefreshHeader *header = [SNRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh) ];

    self.goodListView.header = header;
}

-(void)headRefresh
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 结束刷新
        self.goodListFrame = [NSMutableArray array];
        [self createLocalData];
        [self.goodListView.header endRefreshing];
    });
}

-(void)changeNav
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:NavBarColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title = @"Run Coin";
//    SNButton *titleView = [SNButton buttonWithType:UIButtonTypeCustom];
//    [titleView setBackgroundImage:[UIImage imageNamed:@"home_title_slogan"] forState:UIControlStateNormal];
//    titleView.size = titleView.currentBackgroundImage.size;
//    self.navigationItem.titleView =  titleView;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem CreateItemWithTarget:self ForAction:@selector(searchClick) WithImage:@"icon_fishpond_search" WithHighlightImage:@"icon_fishpond_search"];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem CreateItemWithTarget:self ForAction:@selector(scanClick) WithImage:@"scan_icon" WithHighlightImage:@"scan_icon"];
    
}

#pragma mark -代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.YTList.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath ];
//    cell.image = self.YTList[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ud", indexPath.row);
    SNAnnouncementContentViewController * vc = [[SNAnnouncementContentViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - tableview代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goodListFrame.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeGoodsFrame *goodFrame = self.goodListFrame[indexPath.row];
    
    return goodFrame.cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeGoodsTableViewCell *cell = [HomeGoodsTableViewCell cellWithTableView:tableView];
    cell.goodFrame = self.goodListFrame[indexPath.row];
//    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d", indexPath.row);
    ItemDetailViewController * vc = [[ItemDetailViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
}


-(void)searchClick
{
    
}

-(void)scanClick
{
//    SNSellerViewController * vc = [[SNSellerViewController alloc] init];
////    [self.navigationController pushViewController:vc animated:YES];
//    [self presentViewController:vc animated:YES completion:nil];
//    EthCrypto * eth = [[EthCrypto alloc] init];
//    NSDictionary * dic = [eth createIdentity];
//    NSLog(@"%@", dic);
//    NSString * signature = [eth sign:dic[@"privateKey"] withMessage:@"hello"];
//    NSString * signer = [eth recover:signature withMessage:@"hello"];
//    NSLog(@"%@", signature);
//    NSLog(@"%@", signer);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
