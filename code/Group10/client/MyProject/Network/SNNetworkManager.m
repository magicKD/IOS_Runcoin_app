//
//  NetworkManager.m
//  MyProject
//
//  Created by apple on 2019/12/20.
//  Copyright © 2019 berchina. All rights reserved.
//

#import "SNNetworkManager.h"

@implementation SNNetworkManager

+(id) getInstance{
    static SNNetworkManager * sharedInstance = nil;
    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
            sharedInstance.ipAddress = @"127.0.0.1";
            sharedInstance.port = @"8080";
            
            NSString * urlStr = [NSString stringWithFormat:@"http://%@:%@", sharedInstance.ipAddress, sharedInstance.port];
            NSURL * url = [[NSURL alloc] initWithString:urlStr];
            sharedInstance.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
            
        }
    }
    return sharedInstance;
}

@end
