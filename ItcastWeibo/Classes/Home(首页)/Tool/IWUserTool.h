//
//  IWUserTool.h
//  ItcastWeibo
//
//  Created by apple on 14-5-20.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWUserInfoParam.h"
#import "IWUserInfoResult.h"

#import "IWUserUnreadCountParam.h"
#import "IWUserUnreadCountResutl.h"



@interface IWUserTool : NSObject


/**
 *  加载用户的个人信息
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)userInfoWithParam:(IWUserInfoParam *)param success:(void (^)(IWUserInfoResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载用户的消息未读数
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)userUnreadCountWithParam:(IWUserUnreadCountParam *)param success:(void (^)(IWUserUnreadCountResutl *result))success failure:(void (^)(NSError *error))failure;


@end
