//
//  IWStatusCacheTool.h
//  ItcastWeibo
//
//  Created by kaiyi on 16-7-9.
//  Copyright (c) 2016年 itcast. All rights reserved.
//  微博缓存工具类

#import <Foundation/Foundation.h>
#import "IWHomeStatusesParam.h"

@interface IWStatusCacheTool : NSObject

/**
 *  缓存一条微博
 *  @param dict 需要缓存的微博数据
 */
+(void)addStatus:(NSDictionary *)dict;

/**
 *  缓存N条微博
 *  @param dictArray 需要缓存的微博数据
 */
+(void)addStatuses:(NSArray *)dictArray;


/**
 * 根据请求参数获取微博数据
 * @param  param 请求参数
 * @return 字典数组
 */
+(NSArray *)statuesWithParam:(IWHomeStatusesParam *)param;

@end
