//
//  IWReweetStatusView.h
//  ItcastWeibo
//
//  Created by apple on 14-5-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  微博cell内部 被转发微博的view

#import <UIKit/UIKit.h>
@class IWStatusFrame;
@interface IWReweetStatusView : UIImageView
@property (nonatomic, strong) IWStatusFrame *statusFrame;
@end
