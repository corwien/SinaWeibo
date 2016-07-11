//
//  IWUserUnreadCountParam.h
//  ItcastWeibo
//
//  Created by kaiyi on 16-6-18.
//  Copyright (c) 2016年 itcast. All rights reserved.
//

#import "IWBaseParam.h"

@interface IWUserUnreadCountParam : IWBaseParam

/**
 *  需要查询的用户ID。
 */
@property (nonatomic, strong) NSNumber *uid;


@end
