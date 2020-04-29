//
//  NetworkManager.h
//  MyProject
//
//  Created by apple on 2019/12/20.
//  Copyright © 2019 berchina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


NS_ASSUME_NONNULL_BEGIN

@interface SNNetworkManager : NSObject

@property (nonatomic, strong) NSString * ipAddress;
@property (nonatomic, strong) NSString * port;

@property (nonatomic, strong) AFHTTPSessionManager * manager;

+ (instancetype) getInstance;



@end

NS_ASSUME_NONNULL_END
