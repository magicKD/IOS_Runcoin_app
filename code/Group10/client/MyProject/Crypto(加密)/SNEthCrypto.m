//
//  EthCrypto.m
//  testJS
//
//  Created by apple on 2019/12/20.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SNEthCrypto.h"
#import "AppDelegate.h"

@implementation SNEthCrypto{
    AppDelegate * appDelegate;
}

-(instancetype)init{
    if (self = [super init]){
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return self;
}

+ (instancetype)getInstance{
    static SNEthCrypto *sharedInstance = nil;
    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}


- (NSDictionary *)createIdentity{
    NSString* returnStr =[appDelegate.webView stringByEvaluatingJavaScriptFromString:@"createIdentity()"];
    NSData * jsonData = [returnStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError * err;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    return dic;
}

- (NSString *)sign:(NSString *)privateKey withMessage:(NSString *)message{
    NSString * func = [NSString stringWithFormat:@"sign('%@','%@')", privateKey, message];
    NSString* returnStr =[appDelegate.webView stringByEvaluatingJavaScriptFromString:func];
    NSLog(@"sign('%@','%@')", privateKey, message);
    return returnStr;
}

- (NSString *)recover:(NSString *)signature withMessage:(NSString *)message{
    NSString * func = [NSString stringWithFormat:@"recover('%@','%@')", signature, message];
    NSString* returnStr =[appDelegate.webView stringByEvaluatingJavaScriptFromString:func];
    return returnStr;
}

#pragma mark - 辅助函数
- (NSString *)getCurrentDateStr{
    NSDate * currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss SS"];//设定时间格式,这里可以设置成自己需要的格式
    NSString *dateString = [dateFormatter stringFromDate:currentDate];//将时间转化成字符串
    return dateString;
}

- (NSString *)getSignatureWithAddressAndTimestamp:(SNUserModel *)curUser{
    NSString * dateString = [self getCurrentDateStr];
    NSString * address = curUser.address;
    NSString * message = [NSString stringWithFormat:@"%@+%@", address, dateString];
    NSString * signature = [self sign:curUser.privateKey withMessage:message];
    return signature;
}

- (NSString *)getSignatureWithUser:(SNUserModel *)curUser withTimestamp:(NSString *)dateStr{
    NSString * message = [NSString stringWithFormat:@"%@+%@", curUser.address, dateStr];
    NSString * signature = [self sign:curUser.privateKey withMessage:message];
    NSLog(@"message:%@", message);
    NSLog(@"privateKey:%@", curUser.privateKey);
    return signature;
}

@end
