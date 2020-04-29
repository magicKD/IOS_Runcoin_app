//
//  LoginViewController.m
//  TaoBaoDemo
//
//  Created by fang on 16/3/18.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "TransactionViewController.h"
#import "SNTransactionCateAnimationLogin.h"
//#import "RegisterViewController.h"
#import "AppDelegate.h"
//#import "SLPasswordBackController.h"

#import "SNEthCrypto.h"
#import "SNUserDBManager.h"
#import "SNNetworkManager.h"


#define WL self.view.frame.size.width
#define HL self.view.frame.size.height

@interface TransactionViewController ()


@end

@implementation TransactionViewController
{
    SNTransactionCateAnimationLogin *loginView;
    AppDelegate * delegate;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.view.frame = [[UIScreen mainScreen] bounds];     //必备代码之一
    self.title = @"转账操作";
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(waitingForYou) name:UITextFieldTextDidChangeNotification object:nil];
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
//添加导航控制器上面的左侧返回button
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 40, 40)];
    [leftButton setImage:[UIImage imageNamed:@"view_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(viewBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
//添加用户名和密码模块
    loginView = [[SNTransactionCateAnimationLogin alloc] initWithFrame:CGRectMake(0, 0, WL, 400) withAddress:self.address];
//    loginView.address = self.address;
    NSLog(@"transaction:%@", loginView.address);
    [self.view addSubview:loginView];
    
//添加登录按钮以及注册按钮和找回密码按钮、第三方登录按纽
    self.buttonLogin = [[UIButton alloc] initWithFrame:CGRectMake(20, 400, WL - 40, 40)];
    [self.buttonLogin setBackgroundImage:[UIImage imageNamed:@"login_button"] forState:UIControlStateNormal];
    self.buttonLogin.enabled = NO;
    self.buttonLogin.layer.cornerRadius = 6;
    self.buttonLogin.layer.masksToBounds = YES;
    [self.buttonLogin setTitle:@"转账" forState:UIControlStateNormal];
    [self.buttonLogin addTarget:self action:@selector(buttonLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonLogin];    //添加登录按钮
    
    UIButton *buttonForPasswordBack = [[UIButton alloc] initWithFrame:CGRectMake( WL - 100, HL - 125, 70, 30)];
    [buttonForPasswordBack setTitle:@"找回密码" forState:UIControlStateNormal];
    [buttonForPasswordBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonForPasswordBack.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    buttonForPasswordBack.showsTouchWhenHighlighted = YES;
    [buttonForPasswordBack addTarget:self action:@selector(buttonForPasswordBackAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:buttonForPasswordBack];      //添加找回密码按钮
    
    int tempLength = WL / 2;
    UIButton *buttonRegister = [[UIButton alloc] initWithFrame:CGRectMake(tempLength - 50, HL - 90, 100, 30)];
    [buttonRegister setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonRegister.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    buttonRegister.showsTouchWhenHighlighted = YES;
    [buttonRegister addTarget:self action:@selector(buttonRegisterAction) forControlEvents:UIControlEventTouchUpInside];
    buttonRegister.layer.masksToBounds = YES;
    buttonRegister.layer.cornerRadius = 8.0;
    buttonRegister.layer.borderWidth = 1.0;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorRef = CGColorCreate(colorSpace, (CGFloat[]){1, 0, 0, 1});
    buttonRegister.layer.borderColor = colorRef;
    [buttonRegister setTitle:@"账号注册" forState:UIControlStateNormal];
//    [self.view addSubview:buttonRegister];                //添加免费注册按钮
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)waitingForYou
{
    if (loginView.userNameTextField.text.length != 0 && loginView.PassWordTextField.text.length != 0)
    {
        self.buttonLogin.enabled = YES;
    }else
    {
        self.buttonLogin.enabled = NO;
    }
}


#pragma mark -- 登录、找回密码、注册、第三方登录按钮事件集合
- (void)buttonLoginAction:(UIButton *)sender      //登录按钮
{
    SNEthCrypto * eth = [SNEthCrypto getInstance];
    
    AFHTTPSessionManager * manager = [SNNetworkManager getInstance].manager;
    
    NSString * toAddress = loginView.userNameTextField.text;
    NSString * amount = loginView.PassWordTextField.text;
    
    NSString * dateStr = [eth getCurrentDateStr];
    NSString * signature = [eth getSignatureWithUser:delegate.curUser withTimestamp:dateStr];
    
    NSDictionary * dict = @{
                            @"curAddress":delegate.curUser.address,
                            @"toAddress":toAddress,
                            @"amount":amount,
                            @"dateStr":dateStr,
                            @"signature":signature
                            };
    NSString *url = @"http://127.0.0.1:8080/transfer";
    [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString * str = responseObject[@"message"];
        str = [str lowercaseString];
        if ([str isEqualToString:@"success"]){
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已转账成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *viewBackAction = [UIAlertAction actionWithTitle:@"点击返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                             {
                                                 [self dismissViewControllerAnimated:YES completion:nil];
                                             }];
            [alertController addAction:viewBackAction];
            [self presentViewController:alertController animated:YES completion:nil];
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"转账失败，余额不足" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *viewBackAction = [UIAlertAction actionWithTitle:@"点击返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                             {
                                                 [self dismissViewControllerAnimated:YES completion:nil];
                                             }];
            [alertController addAction:viewBackAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络问题，请重试" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *viewBackAction = [UIAlertAction actionWithTitle:@"点击返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                         {
                                             [self dismissViewControllerAnimated:YES completion:nil];
                                         }];
        [alertController addAction:viewBackAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
    
    
}

- (void)buttonForPasswordBackAction
{
    NSLog(@"用户点击了找回密码");
//    SLPasswordBackController *passwordController = [[SLPasswordBackController alloc] init];
//    [self.navigationController pushViewController:passwordController animated:YES];
}

- (void)buttonRegisterAction            //注册按钮
{
    NSLog(@"用户点击了免费注册按钮");
//    RegisterViewController *reViewController = [[RegisterViewController alloc] init];
//    [self.navigationController pushViewController:reViewController animated:YES];
}

////第三方登录  QQ  微信  微博
//- (void)buttonForTencent
//{
//    NSLog(@"用户点击了腾讯登录");
//}
//
//- (void)buttonForWeChat
//{
//    NSLog(@"用户点击了微信登录");
//}
//
//- (void)buttonForWeibo
//{
//    NSLog(@"用户点击了微博登录");
//}


#pragma mark -- viewBackAction   返回上一级视图
- (void)viewBackAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -- NSURLSession data delegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    //当请求完成的时候会调用该方法，如果请求失败，则error有值
    if (error == nil)
    {
        //解析JSON 数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableContainers error:&error];
        NSString *password = [dic objectForKey:@"password"];
        if ([password isEqualToString:loginView.PassWordTextField.text])
        {
            //NSLog(@"登录成功! password = %@",password);
            appDelegate.userInfomation.phone = [dic objectForKey:@"phone"];
            appDelegate.userInfomation.name = [dic objectForKey:@"name"];
            appDelegate.userInfomation.password = [dic objectForKey:@"password"];
            appDelegate.userInfomation.sex = [dic objectForKey:@"sex"];
            appDelegate.userInfomation.birthday = [dic objectForKey:@"birthday"];
 
            appDelegate.userHasLogin = YES;
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已登录成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *viewBackAction = [UIAlertAction actionWithTitle:@"点击返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                             {
                                                 [self dismissViewControllerAnimated:YES completion:nil];
                                             }];
            [alertController addAction:viewBackAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }else
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message:@"用户名或者密码错误" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:0 handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"可能是手机网络有问题或者服务器繁忙" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"不好" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}



@end
