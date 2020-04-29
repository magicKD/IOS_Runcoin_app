//
//  RegisterViewController.m
//  TaoBaoDemo
//
//  Created by fang on 16/3/19.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "RegisterViewController.h"
#import "SNUserDBManager.h"
#import "SNEthCrypto.h"

#import <AFNetworking/AFNetworking.h>
#import "SNNetworkManager.h"


//#import "ASIFormDataRequest.h"
//#import "ASIHTTPRequest.h"

#define WL self.view.frame.size.width
#define HL self.view.frame.size.height

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"账号注册";
    self.view.frame = [[UIScreen mainScreen] bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    
//新建手机号、验证码、两次密码输入框和获取验证码按钮
    int tempL = WL / 2;
    self.textFieldPhone.delegate = self;
    self.textFieldPhone = [[UITextField alloc] initWithFrame:CGRectMake(tempL - 150, 100, 300, 40)];
    self.textFieldPhone.placeholder = @"请输入用户名";
//    self.textFieldPhone.keyboardType = UIKeyboardTypeNumberPad;
    self.textFieldPhone.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *imageViewPhone = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imageViewPhone.image = [UIImage imageNamed:@"name_image"];
    self.textFieldPhone.leftView = imageViewPhone;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 300, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self.textFieldPhone addSubview:line];
    [self.view addSubview:self.textFieldPhone];      //添加请输入手机号码文本框
    
    self.textFieldVerify = [[UITextField alloc] initWithFrame:CGRectMake(tempL - 150, 160, 300, 40)];
    self.textFieldVerify.placeholder = @"请输入验证码";
    self.textFieldVerify.keyboardType = UIKeyboardTypeNumberPad;
    self.textFieldVerify.rightViewMode = UITextFieldViewModeAlways;
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 300, 1)];
    line2.backgroundColor = [UIColor grayColor];
    [self.textFieldVerify addSubview:line2];
    buttonSendSMS = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSendSMS.frame = CGRectMake(0, 0, 110, 30);
    buttonSendSMS.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [buttonSendSMS setTitle:@"获取验证码" forState:UIControlStateNormal];
    buttonSendSMS.backgroundColor = [UIColor colorWithRed:78/255.0 green:198/255.0 blue:56/255.0 alpha:1];
    self.textFieldVerify.rightView = buttonSendSMS;
    //buttonSendSMS.clipsToBounds = YES;
    buttonSendSMS.layer.cornerRadius = 5.0f;
    [buttonSendSMS addTarget:self action:@selector(buttonSendSMS) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.textFieldVerify];          //添加验证码输入框和获取按钮
    
    //初始化下一步按钮
    buttonNextStep = [[UIButton alloc] initWithFrame:CGRectMake(20, 220, WL - 40, 40)];
    buttonNextStep.backgroundColor = [UIColor colorWithRed:78/255.0 green:198/255.0 blue:56/255.0 alpha:1];
//    buttonNextStep.enabled = NO;
    buttonNextStep.layer.cornerRadius = 6;
    buttonNextStep.layer.masksToBounds = YES;
    [buttonNextStep setTitle:@"下一步" forState:UIControlStateNormal];
    [buttonNextStep addTarget:self action:@selector(buttonNextStep) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonNextStep];
    
    //初始化姓名文本框、两个密码文本框和注册按钮
    self.textFieldName = [[UITextField alloc] initWithFrame:CGRectMake(tempL - 150, 220, 300, 40)];
    self.textFieldName.placeholder = @"请再次输入用户名";
    self.textFieldName.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *imageViewName = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imageViewName.image = [UIImage imageNamed:@"name_image"];
    self.textFieldName.leftView = imageViewName;
    UIView *lineX = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 300, 1)];
    lineX.backgroundColor = [UIColor grayColor];
    [self.textFieldName addSubview:lineX];
    self.textFieldName.hidden = YES;
    self.textFieldName.delegate = self;
    [self.view addSubview:self.textFieldName];              //添加用户姓名文本框
    
    self.textFieldPassword1 = [[UITextField alloc] initWithFrame:CGRectMake(tempL - 150, 220, 300, 40)];
    self.textFieldPassword1.placeholder = @"请输入您的密码(至少6位)";
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 300, 1)];
    line3.backgroundColor = [UIColor grayColor];
    [self.textFieldPassword1 addSubview:line3];
    self.textFieldPassword1.hidden = YES;
    self.textFieldPassword1.secureTextEntry = YES;
    self.textFieldPassword1.delegate = self;
    self.textFieldPassword1.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *imageViewPassword1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imageViewPassword1.image = [UIImage imageNamed:@"password_image"];
    self.textFieldPassword1.leftView = imageViewPassword1;
    [self.view addSubview:self.textFieldPassword1];             //添加第一个密码文本框
    
    self.textFieldPassword2 = [[UITextField alloc] initWithFrame:CGRectMake(tempL - 150, 220, 300, 40)];
    self.textFieldPassword2.placeholder = @"请再次输入您的密码";
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 300, 1)];
    line4.backgroundColor = [UIColor grayColor];
    [self.textFieldPassword2 addSubview:line4];
    self.textFieldPassword2.hidden = YES;
    self.textFieldPassword2.secureTextEntry = YES;
    self.textFieldPassword2.delegate = self;
    self.textFieldPassword2.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *imageViewPassoword2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imageViewPassoword2.image = [UIImage imageNamed:@"password_image"];
    self.textFieldPassword2.leftView = imageViewPassoword2;
    [self.view addSubview:self.textFieldPassword2];             //添加第二个密码文本框
    
    buttonRegister = [[UIButton alloc] initWithFrame:CGRectMake(20, 400, WL - 40, 40)];
    buttonRegister.backgroundColor = [UIColor colorWithRed:78/255.0 green:198/255.0 blue:56/255.0 alpha:1];
    buttonRegister.hidden = YES;
    buttonRegister.layer.cornerRadius = 6.0f;
    buttonRegister.layer.masksToBounds = YES;
    [buttonRegister setTitle:@"注册" forState:UIControlStateNormal];
    [buttonRegister addTarget:self action:@selector(buttonRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonRegister];           //添加注册按钮
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark -- button相关事件
- (void)buttonSendSMS
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"成功请求验证码:1234" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)buttonNextStep
{
    NSLog(@"click!");
    //验证成功后的回调
    [self.view endEditing:YES];
    [UIView animateWithDuration:1 animations:^
     {
         buttonNextStep.frame = CGRectMake(20, 400, WL - 40, 40);
     } completion:^(BOOL finished)
     {
         buttonRegister.hidden = NO;
         self.textFieldPassword2.hidden = NO;
         [UIView animateWithDuration:0.5 animations:^
          {
              self.textFieldPassword2.frame = CGRectMake(WL / 2 - 150, 340, 300, 40);
          } completion:^(BOOL finished)
          {
              self.textFieldPassword1.hidden = NO;
              [UIView animateWithDuration:0.5 animations:^
               {
                   self.textFieldPassword1.frame = CGRectMake(WL / 2 - 150, 280, 300, 40);
               } completion:^(BOOL finished)
               {
                   self.textFieldName.hidden = NO;
               }];
          }];
     }];
}

- (void)buttonRegister
{
    SNUserDBManager * db = [SNUserDBManager getInstance];
    
    SNEthCrypto * eth = [[SNEthCrypto alloc] init];
    NSDictionary * dic = [eth createIdentity];
    SNUserModel * user = [[SNUserModel alloc] init];
    user.address = dic[@"address"];
    user.publicKey = dic[@"publicKey"];
    user.privateKey = dic[@"privateKey"];
    user.userName = self.textFieldPhone.text;
    user.password = self.textFieldPassword1.text;
    
    bool isCreated = [db createUser:user];
    
    
    if (isCreated){
//        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        AFHTTPSessionManager * manager = [SNNetworkManager getInstance].manager;
        NSDictionary * dict = @{
                                @"address": user.address,
                                @"publicKey": user.publicKey
                                };
        NSString *url = @"http://127.0.0.1:8080/register";
        [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           //请求成功
            NSLog(@"%@", responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 请求失败
            NSLog(@"Network Error!");
            NSLog(@"%@", error);
        }];
        
        [self.view endEditing:YES];
        self.responseData = [[NSMutableData alloc] init];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户注册成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                   {
                                       //                                   sleep(3);
                                       [self.navigationController popViewControllerAnimated:YES];
                                   }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        [self.view endEditing:YES];
        self.responseData = [[NSMutableData alloc] init];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户注册失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                   {
                                       //                                   sleep(3);
                                       [self.navigationController popViewControllerAnimated:YES];
                                   }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }

}


#pragma mark -- _timer定时器事件
- (void)timerBegan
{
    [buttonSendSMS setTitle:[NSString stringWithFormat:@"(%d)后可重新获取",numberTimeLeft] forState:UIControlStateNormal];
    if (numberTimeLeft == 1 || numberTimeLeft < 1)
    {
        [_timer invalidate];
        [buttonSendSMS setTitle:@"获取验证码" forState:UIControlStateNormal];
        buttonSendSMS.backgroundColor = [UIColor colorWithRed:78/255.0 green:198/255.0 blue:56/255.0 alpha:1];
        buttonSendSMS.enabled = YES;
    }
    numberTimeLeft = numberTimeLeft - 1;
}


#pragma mark -- UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectMake(0, -100, WL, HL);
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectMake(0, 0, WL, HL);
    [UIView commitAnimations];
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
        NSArray *array = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableContainers error:nil];
        if ([[array lastObject] boolValue])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户注册成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
               {
//                   sleep(0.5);
                   [self.navigationController popViewControllerAnimated:YES];
               }];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }else
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户之前已经注册过，无须再次注册，点击确定后3秒返回上一界面" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                {
//                    sleep(3);
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"可能是手机网络有问题或者服务器繁忙" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"不好" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}




@end
