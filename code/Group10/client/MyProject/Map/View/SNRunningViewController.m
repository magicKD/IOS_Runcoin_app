//
//  SNRunningViewController.m
//  RunApp
//
//  Created by BenTsai on 2019/12/17.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#import "SNRunningViewController.h"
#import "SNTimeManager.h"
#import "SNCountdownView.h"
#import "SNMapViewController.h"
#import "SNRunningModeDataView.h"
#import "SNTimeLabel.h"
#import "SNRunningResultViewController.h"
#import "SNRunInfoModel.h"
typedef NS_ENUM(NSInteger, RunningState) {
    RunningStateNone = 0,
    RunningStateStart,
    RunningStateEnd
};

@interface SNRunningViewController () <SNMapViewDelegate, SNTimeManagerDelegate, SNCountdownViewDelegate>

@property (nonatomic, strong) SNMapViewController *mapViewController;
@property (nonatomic, strong) SNCountdownView *countdownView;
@property (nonatomic, strong) SNRunningModeDataView* dataView;
@property (nonatomic, strong) SNTimeLabel* timeLabel;
@property (nonatomic, strong) SNTimeManager *timeManager;
@property (nonatomic, assign) dispatch_once_t onceDispatch;
@property (nonatomic, strong) UIButton *bottomButton;
@property (nonatomic, strong) SNRunInfoModel *runInfoModel;

@end

@implementation SNRunningViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    self.runInfoModel = [[SNRunInfoModel alloc]init];
    [self addSubviews];
    [self initTimeManager];
    self.navigationController.navigationBarHidden = NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)updateDistance:(CGFloat)distance{
    CGFloat pace = 0;
    
    // distance单位为公里，刚开始位置有小距离波动，大于一定距离时才进行配速计算，否则配速得到的值会很大
    if (distance > 0.03)
    {
        CGFloat min = (CGFloat)[self.timeManager currentAccumulatedTime] / 60;
        pace = (1 / distance) * min;
    }
    self.runInfoModel.distance = distance;
    self.runInfoModel.speed = pace;
    [self.dataView setPace:pace];
    [self.dataView setDistance:distance];
}

- (void)addSubviews
{
    self.countdownView = [SNCountdownView new];
    self.countdownView.delegate = self;
    
    self.dataView = [[[UINib nibWithNibName:@"SNRunningModeDataView" bundle:nil] instantiateWithOwner:self options:nil] firstObject];
    self.dataView.frame = CGRectMake(0, self.view.bounds.size.height*3/4, self.view.bounds.size.width, self.view.bounds.size.height*1/7);
    self.timeLabel = [[[UINib nibWithNibName:@"SNTimeLabel" bundle:nil] instantiateWithOwner:self options:nil] firstObject];
    self.timeLabel.frame = CGRectMake(0, self.view.bounds.size.height*3/4, self.view.bounds.size.width, self.view.bounds.size.height*1/4);
    self.mapViewController = [[SNMapViewController alloc] init];
    self.mapViewController.delegate = self;
    [self.mapViewController.view addSubview:self.mapViewController.mapView];
    self.mapViewController.mapView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:_mapViewController.view];
    
    self.bottomButton = [[UIButton alloc] init];
    self.bottomButton.layer.cornerRadius = 8;
    self.bottomButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomButton.titleLabel.textColor = [UIColor whiteColor];
    self.bottomButton.backgroundColor = [UIColor colorWithRed:100/255. green:200/255. blue:100/255. alpha:1.];
    [self.bottomButton setTitle:@"结束跑步" forState:UIControlStateNormal];
    [self.bottomButton addTarget:self action:@selector(finishRunning) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bottomButton];
    [self.bottomButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0].active = YES;
    [self.bottomButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:40].active = YES;
    [self.bottomButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-40].active = YES;
}

- (void)initTimeManager
{
    self.timeManager = [SNTimeManager new];
    self.timeManager.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void) finishRunning{
    [self.timeManager pause];
    [self.mapViewController endLocation];
    self.mapViewController.mapView.showsCompass = NO;
    self.runInfoModel.mapView = self.mapViewController.mapView;
    self.runInfoModel.locationArray = self.mapViewController.annotationRecordArray;
    SNRunningResultViewController *resultViewController = [[SNRunningResultViewController alloc] initWithRunData:self.runInfoModel];
    [self.navigationController pushViewController:resultViewController animated:YES];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.mapViewController setupMapView];
    [self.view addSubview:self.dataView];
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.countdownView];
    [self.countdownView startAnimationCountdownWithTime:3];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    // 子视图的设置只需要设置一次，否则会导致拖动下拉按钮位置闪烁的问题。
    dispatch_once(&_onceDispatch, ^{
        self.countdownView.frame = self.view.bounds;
        [self.view bringSubviewToFront:self.countdownView];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startRun
{
    [self.view bringSubviewToFront:self.bottomButton];
    [self.timeManager start];
    //[self setupRunningInfoWithState:RunningStateStart];
    [self.mapViewController startLocation];
}

#pragma mark - SNTimeManagerDelegate

- (void)tickWithAccumulatedTime:(NSUInteger)time
{
    [self.timeLabel resetTimeLabelWithTotalSeconds:time];
    self.runInfoModel.useTime = time;
    CGFloat pace = 0;
    CGFloat distance = self.runInfoModel.distance;
    // distance单位为公里，刚开始位置有小距离波动，大于一定距离时才进行配速计算，否则配速得到的值会很大
    if (distance > 0.03)
    {
        CGFloat min = (CGFloat) time / 60;
        pace = (1 / distance) * min;
    }
    self.runInfoModel.speed = pace;
    [self.dataView setPace:pace];
}

#pragma mark - SNCountdownViewDelegate

- (void)countdownFinish
{
    [self startRun];
}

@end
