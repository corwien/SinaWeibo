//
//  IWHomeStatusesParam.h
//  ItcastWeibo
//
//  Created by apple on 14-5-20.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  封装加载首页微博数据的参数

#import <Foundation/Foundation.h>
#import "IWBaseParam.h"

@interface IWHomeStatusesParam : IWBaseParam
/**
 *  若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 */
@property (nonatomic, strong) NSNumber *since_id;

/**
 *  若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 */
@property (nonatomic, strong) NSNumber *max_id;

/**
 *  单页返回的记录条数，最大不超过100，默认为20。
 */
@property (nonatomic, strong) NSNumber *count;
@end
