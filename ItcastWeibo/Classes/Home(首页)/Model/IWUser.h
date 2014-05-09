//
//  IWUser.h
//  ItcastWeibo
//
//  Created by apple on 14-5-8.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  微博用户(发微博的作者)

#import <Foundation/Foundation.h>

@interface IWUser : NSObject
/**
 *  用户的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  用户的昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  用户的头像
 */
@property (nonatomic, copy) NSString *profile_image_url;
@end
/*
 {
     "id": 1404376560,
     "name": "zaku",
     "profile_image_url": "http://tp1.sinaimg.cn/1404376560/50/0/1",
 }
*/