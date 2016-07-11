//
//  IWUserUnreadCountResutl.h
//  ItcastWeibo
//
//  Created by kaiyi on 16-6-18.
//  Copyright (c) 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWUserUnreadCountResutl : NSObject

// 新微薄未读数
@property (nonatomic, assign) int status;

// 新粉丝数
@property (nonatomic, assign) int follower;

// cmt
@property (nonatomic, assign) int cmt;

// 新私信数
@property (nonatomic, assign) int dm;

// 新通知未读数
@property (nonatomic, assign) int notice;

// 新提及我的微博数
@property (nonatomic, assign) int mention_status;


// 新提及我的评论数
@property (nonatomic, assign) int mention_cmt;

// 未读消息的总数
-(int)messageCount;

// 总数
-(int)totalCount;

@end
