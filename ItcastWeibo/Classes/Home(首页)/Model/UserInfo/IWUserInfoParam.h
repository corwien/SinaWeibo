//
//  IWUserInfoParam.h
//  ItcastWeibo
//
//  Created by apple on 14-5-20.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  封装加载用户信息的参数

#import <Foundation/Foundation.h>
#import "IWBaseParam.h"

@interface IWUserInfoParam : IWBaseParam
/**
 *  需要查询的用户ID。
 */
@property (nonatomic, strong) NSNumber *uid;

/**
 *  需要查询的用户昵称。
 */
@property (nonatomic, copy) NSString *screen_name;
@end
