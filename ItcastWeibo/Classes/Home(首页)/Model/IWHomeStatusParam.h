//
//  IWHomeStatusParam.h
//  ItcastWeibo
//
//  Created by kaiyi on 16-6-3.
//  Copyright (c) 2016年 itcast. All rights reserved.
//
// 封装加载首页微博数据的参数
#import <Foundation/Foundation.h>

@interface IWHomeStatusParam : NSObject

// 授权token
@property (nonatomic, copy) NSString *access_token;

// 返回ID比since_id大的微博
@property (nonatomic, assign) long long since_id;

@property (nonatomic, assign) long long max_id;

@property (nonatomic, assign) int count;


@end
