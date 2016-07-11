//
//  IWAppDelegate.m
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWAppDelegate.h"
#import "IWOAuthViewController.h"
#import "IWAccount.h"
#import "IWWeiboTool.h"
#import "IWAccountTool.h"
#import "IWNewfeatureViewController.h"
#import "SDWebImageManager.h"

@implementation IWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    // 先判断有无存储账号信息
    IWAccount *account = [IWAccountTool account];
    
    if (account) { // 之前登录成功
        [IWWeiboTool chooseRootController];
    } else { // 之前没有登录成功
        self.window.rootViewController = [[IWOAuthViewController alloc] init];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

/**
 * 让程序保持后台运行
 * 1.尽量申请后台运行的时间
 [application beginBackgroundTaskWithExpirationHandler:^{}
 
 * 2.在Info.plist中声明自己的应用类型
 *
 */

/**
 * App进入后台会调用这个方法
 */
- (void)applicationDidEnterBackground:(UIApplication *)application
{
   // 在后台开启任务让程序持续保持运行状态（能保持运行的时间是不确定）
    [application beginBackgroundTaskWithExpirationHandler:^{
        // IWLog(@"哈哈，后台继续运行---");
    }];
    
    // 本地通知（定时提醒弹框）
    // [UILocalNotification ];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 停止下载所有图片
    [[SDWebImageManager sharedManager] cancelAll];
    // 清除内存中的图片
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

@end
