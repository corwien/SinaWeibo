//
//  IWStatusTool.h
//  ItcastWeibo
//
//  Created by apple on 14-5-20.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  微博业务处理类（工具类）

#import <Foundation/Foundation.h>

#import "IWHomeStatusesParam.h"
#import "IWHomeStatusesResult.h"
#import "IWSendStatusParam.h"
#import "IWSendStatusResult.h"

@interface IWStatusTool : NSObject

/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)homeStatusesWithParam:(IWHomeStatusesParam *)param success:(void (^)(IWHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一条微博
 */
+ (void)sendStatusWithParam:(IWSendStatusParam *)param success:(void (^)(IWSendStatusResult *result))success failure:(void (^)(NSError *error))failure;
@end
