//
//  IWSendStatusParam.h
//  ItcastWeibo
//
//  Created by apple on 14-5-20.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  封装发微博的参数

#import <Foundation/Foundation.h>
#import "IWBaseParam.h"
@interface IWSendStatusParam : IWBaseParam

/**
 *  要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
 */
@property (nonatomic, copy) NSString *status;
@end
