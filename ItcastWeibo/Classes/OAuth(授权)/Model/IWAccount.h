//
//  IWAccount.h
//  ItcastWeibo
//
//  Created by apple on 14-5-8.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  帐号模型

#import <Foundation/Foundation.h>

@interface IWAccount : NSObject <NSCoding>
@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, strong) NSDate *expiresTime; // 账号的过期时间
// 如果服务器返回的数字很大, 建议用long long(比如主键, ID)
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
@property (nonatomic, assign) long long uid;

/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *name;


+ (instancetype)accountWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
