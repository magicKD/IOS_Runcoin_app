//
//  ShopImageDetailController.m
//  MyProject
//
//  Created by apple on 2019/12/18.
//  Copyright © 2019 berchina. All rights reserved.
//

#import "ShopImageDetailController.h"

@interface ShopImageDetailController ()<UITableViewDataSource,UITableViewDelegate>
{
    int heightDict;
}
@property(nonatomic,strong)NSMutableArray *imagearr;

@end

@implementation ShopImageDetailController
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
    return _imagearr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetaImagetableViewCell *cell=[DetaImagetableViewCell WithDetaImagetableViewCell:tableView];
    cell.image.tag=indexPath.row;
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}


- (void)configureCell:(DetaImagetableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    ShopModel *model=_imagearr[indexPath.row];
    NSString *imgURL = model.url;
    UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imgURL];
    if ( !cachedImage ) {
        [self downloadImage:imgURL forIndexPath:indexPath];
        cell.image.image =GHImage(@"MaxBackimage");
    } else {
        cell.image.image=cachedImage;
    }
}
- (void)downloadImage:(NSString *)imageURL forIndexPath:(NSIndexPath *)indexPath {
    // 利用 SDWebImage 框架提供的功能下载图片
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageURL] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        // do nothing
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        [[SDImageCache sharedImageCache] storeImage:image forKey:imageURL toDisk:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableview reloadData];
        });
    }];
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    return 250;
    ShopModel *model=_imagearr[indexPath.row];
    NSString *imgURL = model.url;
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imgURL];
    // 没有找到已下载的图片就使用默认的占位图，当然高度也是默认的高度了，除了高度不固定的文字部分。
    if (!image) {
        image =GHImage(@"MaxBackimage");
    }
    //手动计算cell
    CGFloat imgHeight = image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width;
    return imgHeight;
    //
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _imagearr=@[].mutableCopy;
    [self tableview];
   
    NSArray *imagearr=@[
                                @{@"url":@"http://officialwebsitestorage.blob.core.chinacloudapi.cn/public/upload/attachment/2015/11/201511061700247469.png"},
                                @{@"url":@"http://officialwebsitestorage.blob.core.chinacloudapi.cn/public/upload/attachment/2015/11/201511061701025899.png"},
                                @{@"url":@"http://officialwebsitestorage.blob.core.chinacloudapi.cn/public/upload/attachment/2015/11/201511061707075050.png"},
                                @{@"url":@"http://officialwebsitestorage.blob.core.chinacloudapi.cn/public/upload/attachment/2018/06/201806281011087265.png"},
                                @{@"url":@"http://officialwebsitestorage.blob.core.chinacloudapi.cn/public/upload/attachment/2015/11/201511061705331634.png"},
                                @{@"url":@"http://officialwebsitestorage.blob.core.chinacloudapi.cn/public/upload/attachment/2018/06/201806271648252562.png"},
                                ];
    for (NSDictionary *dic in imagearr) {
        NSLog(@"%@",dic);
        ShopModel *model=[ShopModel mj_objectWithKeyValues:dic];
        [_imagearr addObject:model];
    }
//    ShopModel *model=[[ShopModel alloc]init];
//    model.url=@"https://img.alicdn.com/imgextra/i2/2669183559/TB22jOKFAOWBuNjSsppXXXPgpXa_!!2669183559.png";
//    [_imagearr addObject:model];
    
    [self.tableview reloadData];
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
