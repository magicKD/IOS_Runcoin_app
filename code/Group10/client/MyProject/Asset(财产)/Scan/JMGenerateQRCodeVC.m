//
//  JMGenerateQRCodeViewController.m
//  MyProject
//
//  Created by apple on 2019/12/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JMGenerateQRCodeVC.h"
#import "JMGenerateQRCodeUtils.h"

#import "AppDelegate.h"

@interface JMGenerateQRCodeVC ()

@end

@implementation JMGenerateQRCodeVC{
    AppDelegate * delegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"二维码";

    [self generateQRCode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)generateQRCode {
    CGSize size         = CGSizeMake(200, 200);
//    float  off          = 30;
//    NSString *string    = @"https://github.com/xiaobs/JMQRCode.git";
    NSString * string  = delegate.curUser.address;
//    NSString * string =
//    NSString *logoName  = @"logo";
//    CGSize logoSize     = CGSizeMake(30, 30);
    
    UIImage * image = [JMGenerateQRCodeUtils jm_generateQRCodeWithString:string imageSize:size];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
    
    
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [imageView.widthAnchor constraintEqualToConstant:size.width].active=true;
    [imageView.heightAnchor constraintEqualToConstant:size.height].active=true;
    [imageView.centerXAnchor constraintEqualToAnchor:self.view.leftAnchor constant:self.view.frame.size.width / 2].active=true;
    [imageView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active=true;
    
    
}

@end
