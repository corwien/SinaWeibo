//
//  IWHttpTool.h
//  ItcastWeibo
//
//  Created by kaiyi on 16-5-29.
//  Copyright (c) 2016年 itcast. All rights reserved.
//
//   封装整个项目的GET\POST请求

#import <Foundation/Foundation.h>

@interface IWHttpTool : NSObject

/**
 * 发送一个POST请求
 *
 * @param url       请求路径
 * @param params    请求参数
 * @param formData  文件参数
 * @param success   请求成功后的回调
 * @param failure   请求失败后的回调
 *
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray: (NSArray *) formDataArray success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

/**
 * 发送一个GET请求
 *
 * @param url       请求路径
 * @param params    请求参数
 * @param formData  文件参数
 * @param success   请求成功后的回调
 * @param failure   请求失败后的回调
 *
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params formDataArray: (NSArray *) formDataArray  success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;


@end
