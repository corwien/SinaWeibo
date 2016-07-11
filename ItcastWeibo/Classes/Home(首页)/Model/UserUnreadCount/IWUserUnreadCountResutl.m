//
//  IWUserUnreadCountResutl.m
//  ItcastWeibo
//
//  Created by kaiyi on 16-6-18.
//  Copyright (c) 2016年 itcast. All rights reserved.
//

#import "IWUserUnreadCountResutl.h"

@implementation IWUserUnreadCountResutl
-(int)messageCount
{
    return self.cmt + self.mention_cmt + self.mention_status + self.dm;
    
}

-(int)totalCount
{
    return self.messageCount + self.follower + self.status;
    
}


@end
