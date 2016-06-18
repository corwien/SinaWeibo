//
//  IWBaseParam.m
//  ItcastWeibo
//
//  Created by apple on 14-5-20.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWBaseParam.h"
#import "IWAccount.h"
#import "IWAccountTool.h"

@implementation IWBaseParam
- (id)init
{
    if (self = [super init]) {
        self.access_token = [IWAccountTool account].access_token;
    }
    return self;
}

+ (instancetype)param
{
    return [[self alloc] init];
}

//- (NSString *)access_token
//{
//    if (_access_token == nil) {
//        self.access_token = [IWAccountTool account].access_token;
//    }
//    return _access_token;
//}
@end
