//
//  IWStatusTool.m
//  ItcastWeibo
//
//  Created by kaiyi on 16-6-3.
//  Copyright (c) 2016年 itcast. All rights reserved.

#import "IWStatusTool.h"
#import "IWHttpTool.h"
#import "IWStatusCacheTool.h"
#import "MJExtension.h"

@implementation IWStatusTool



+(void)homeStatusesWithParam:(IWHomeStatusesParam *)param success:(void (^)(IWHomeStatusesResult *))success failure:(void (^)(NSError *))failure
{
    // 1.先从缓存里边加载
    NSArray *dicArray = [IWStatusCacheTool statuesWithParam:param];
    if(dicArray.count){ // 有缓存
        // 传递了block
        if (success) {
            IWHomeStatusesResult *result = [[IWHomeStatusesResult alloc] init];
            
            result.statuses = [IWStatus objectArrayWithKeyValuesArray:dicArray];
            
            success(result);
        }
    }
    else
    {
        [IWHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.keyValues success:^(id json)
         {
             // 缓存 -[2016-07-09 add]
             [IWStatusCacheTool addStatuses:json[@"statuses"]];
             // NSArray *dictArray = json[@"status"];
             
             
             // 请求成功后，新浪返回类型为字典的json,这里需要将字典转为模型
             if(success){
                 IWHomeStatusesResult *result = [IWHomeStatusesResult objectWithKeyValues:json];
                 
                 success(result);
             }
             
         } failure:^(NSError *error) {
             if(failure){
                 failure(error);
             }
         }];

        
    }
}

+ (void)sendStatusWithParam:(IWSendStatusParam *)param success:(void (^)(IWSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    [IWHttpTool postWithURL:@"https://api.weibo.com/2/statuses/update.json" params:param.keyValues success:^(id json) {
        if (success) {
            IWSendStatusResult *result = [IWSendStatusResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end

