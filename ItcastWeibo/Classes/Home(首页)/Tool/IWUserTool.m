//
//  IWUserTool.m
//  ItcastWeibo
//
//  Created by apple on 14-5-20.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  用户业务处理类（工具类）

#import "IWUserTool.h"
#import "IWHttpTool.h"
#import "MJExtension.h"

@implementation IWUserTool

+ (void)userInfoWithParam:(IWUserInfoParam *)param success:(void (^)(IWUserInfoResult *))success failure:(void (^)(NSError *))failure
{
    [IWHttpTool getWithURL:@"https://api.weibo.com/2/users/show.json" params:param.keyValues success:^(id json) {
        if (success) {
            IWUserInfoResult *result = [IWUserInfoResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userUnreadCountWithParam:(IWUserUnreadCountParam *)param success:(void (^)(IWUserUnreadCountResutl *))success failure:(void (^)(NSError *))failure
{
    
    [IWHttpTool getWithURL:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:param.keyValues success:^(id json) {
        if (success) {
            IWUserUnreadCountResutl *result = [IWUserUnreadCountResutl objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}

@end
