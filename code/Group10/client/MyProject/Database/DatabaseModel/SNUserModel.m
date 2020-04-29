//
//  SNUserModel.m
//  RunDB
//
//  Created by Ben Tsai on 2019/12/20.
//  Copyright © 2019 Student. All rights reserved.
//

#import "SNUserModel.h"

@implementation SNUserModel

-(NSString *) description{
    return [NSString stringWithFormat:@"userName:%@\npassword:%@\nprivateKey:%@\npublicKey:%@\naddress;:%@\n",self.userName,self.password,self.privateKey,self.publicKey,self.address];
}


@end
