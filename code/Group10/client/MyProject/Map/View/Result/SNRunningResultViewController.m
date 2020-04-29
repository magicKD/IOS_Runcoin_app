//
//  SNRunningResultViewController.m
//  RunApp
//
//  Created by BenTsai on 2019/12/16.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#import "SNRunningResultViewController.h"
#import "SNResultRecordView.h"
#import "SNMacro.h"
#import "SNRunInfoModel.h"
#import <MAMapKit/MAMapKit.h>
#import "SNMapPaintFunc.h"
@interface SNRunningResultViewController () <SNResultRecordViewDelegate>

@property (nonatomic, weak) IBOutlet SNResultRecordView *resultRecordView;

@property (nonatomic, weak) IBOutlet UIView *mapContentView;
@property (nonatomic, weak) IBOutlet MAMapView *mapView;

@property (nonatomic, strong) SNRunInfoModel *runInfoModel;

@property (nonatomic, strong) SNMapPaintFunc *mapPaintFunc;
@property (nonatomic, strong) UIImage *screenshotImage;

@end

@implementation SNRunningResultViewController

- (id)initWithRunData:(SNRunInfoModel *)runInfoModel
{
    self = [super init];
    if (self)
    {
        self.runInfoModel = runInfoModel;
        self.mapPaintFunc = [SNMapPaintFunc new];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.resultRecordView setupRecordWith:self.runInfoModel];
    self.resultRecordView.delegate = self;
    
    [self.mapPaintFunc drawPathWithAnnotationArray:self.runInfoModel.locationArray inMapView:self.mapView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.mapPaintFunc drawPathWithAnnotationArray:self.runInfoModel.locationArray inMapView:self.mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - SNResultRecordViewDelegate

- (void)resultRecordViewBack
{
//    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
