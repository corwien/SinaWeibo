//
//  IWTabBar.h
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IWTabBar;

@protocol IWTabBarDelegate <NSObject>

@optional
- (void)tabBar:(IWTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;
- (void)tabBarDidClickedPlusButton:(IWTabBar *)tabBar;

@end

@interface IWTabBar : UIView
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic, weak) id<IWTabBarDelegate> delegate;

@end
