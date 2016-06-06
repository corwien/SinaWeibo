//
//  IWStatusTool.h
//  ItcastWeibo
//
//  Created by kaiyi on 16-6-3.
//  Copyright (c) 2016年 itcast. All rights reserved.
//// 业务处理类（工具类）


#import <Foundation/Foundation.h>
@class IWHomeStatusParam;

@interface IWStatusTool : NSObject

+ (void)homeStatusesWithParam:(IWHomeStatusParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
