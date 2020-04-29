//
//  SNUserDBManager.m
//  RunDB
//
//  Created by Ben Tsai on 2019/12/20.
//  Copyright © 2019 Student. All rights reserved.
//

#import "SNUserDBManager.h"

@interface SNUserDBManager ()

@property (strong, nonatomic) FMDatabase *database;
- (void)initDB;

@end

@implementation SNUserDBManager


- (void)dealloc{
    if(self.database){
        [self.database close];
    }
}

+ (SNUserDBManager *)getInstance{
    //多线程单例模式
    static SNUserDBManager * dbmgr = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (dbmgr == nil) {
            dbmgr = [[SNUserDBManager alloc] init];
        }
    });
    [dbmgr initDB];
    return (SNUserDBManager *)dbmgr;
}

- (void)openDB{
    if(![self.database open]){
        NSString *home=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path=[home stringByAppendingPathComponent:@"user.db"];
        self.database=[[FMDatabase alloc]initWithPath:path];
    }
}

- (void)initDB{
    if(self.database==nil){
        [self openDB];
        if ([self.database open]) {
            NSLog(@"打开成功");
        }
        else{
            NSLog(@"打开失败");
        }
      if ([self.database open]) {
          NSString *createTableSql = @"create table if not exists User(username text primary key, password text not null, privateKey text not null, publicKey text not null,address text not null)";
          BOOL result = [self.database executeUpdate:createTableSql];
         if(result) {
            NSLog(@"打开表成功");
        } else {
            NSLog(@"打开表失败");
        }
        // 每次执行完对应SQL之后，要关闭数据库
        [self.database close];
        }
    }
}

//检查用户和密码，用于登陆后用于获得用户的信息
- (SNUserModel*) Login:(NSString*)username Password:(NSString*)password{
    [self openDB];
    if ([self.database open]){
    FMResultSet *result = [self.database executeQuery:@"select * from 'User' where username = ?" withArgumentsInArray:@[username]];
    while ([result next]) {
        if([password isEqualToString:[result stringForColumn:@"password"]]!=YES){
            return nil;//密码错误
        }
        SNUserModel *user = [[SNUserModel alloc]init];
        user.userName = [result stringForColumn:@"username"];;
        user.password = [result stringForColumn:@"password"];
        user.privateKey = [result stringForColumn:@"privateKey"];
        user.publicKey = [result stringForColumn:@"publicKey"];
        user.address = [result stringForColumn:@"address"];
        return user;
    }
        return nil;//没找到对应账号
    }
    return nil;
}

//注册用户
- (bool) createUser:(SNUserModel*)user{
    [self openDB];
    if ([self.database open]) {
        NSString *insertSql = @"insert into User(username, password, privateKey, publicKey,address) values(?, ?, ?, ?, ?)";
        BOOL result = [self.database executeUpdate:insertSql, user.userName, user.password, user.privateKey,user.publicKey,user.address];
        // 每次执行完对应SQL之后，要关闭数据库
        [self.database close];
        if (result) {
            NSLog(@"插入数据成功");
            return true;
        } else {
            //可能是账号名冲突了
            NSLog(@"插入数据失败");
            return false;
        }
    }
    return false;
}

//删除用户
- (bool) deleteUser:(NSString*)username{
    [self openDB];
    if ([self.database open]) {
        BOOL result = [self.database executeUpdate:@"delete from 'User' where username = ?" withArgumentsInArray:@[username]];
        [self.database close];
        if (result) {
            return true;
        } else {
            return false;
        }
    }
    return false;
}

@end
