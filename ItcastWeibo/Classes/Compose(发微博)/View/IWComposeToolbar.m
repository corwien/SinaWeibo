//
//  IWComposeToolbar.m
//  ItcastWeibo
//
//  Created by kaiyi on 16-5-15.
//  Copyright (c) 2016年 itcast. All rights reserved.
//

#import "IWComposeToolbar.h"

@implementation IWComposeToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 设置工具条背景图片，平铺
      self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
       // self.backgroundColor = [UIColor redColor];
    }
    return self;
    //
}



@end
