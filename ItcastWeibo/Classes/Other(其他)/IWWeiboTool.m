//
//  IWWeiboTool.m
//  ItcastWeibo
//
//  Created by apple on 14-5-8.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWWeiboTool.h"
#import "IWTabBarViewController.h"
#import "IWNewfeatureViewController.h"

@implementation IWWeiboTool
+ (void)chooseRootController
{
    NSString *key = @"CFBundleVersion";
    
    // 取出沙盒中存储的上次使用软件的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        // 显示状态栏
        [UIApplication sharedApplication].statusBarHidden = NO;
        [UIApplication sharedApplication].keyWindow.rootViewController = [[IWTabBarViewController alloc] init];
    } else { // 新版本
        [UIApplication sharedApplication].keyWindow.rootViewController = [[IWNewfeatureViewController alloc] init];
        // 存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
}
@end
