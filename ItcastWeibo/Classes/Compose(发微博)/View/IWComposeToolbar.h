//
//  IWComposeToolbar.h
//  ItcastWeibo
//
//  Created by kaiyi on 16-5-15.
//  Copyright (c) 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWComposeToolbar;

// 定义toolbar工具条上的按钮类型
typedef enum {
    
    IWComposeToolbarButtonTypeCamera,
    IWComposeToolbarButtonTypePicture,
    IWComposeToolbarButtonTypeMention,
    IWComposeToolbarButtonTypeTrend,
    IWComposeToolbarButtonTypeEmotion,
} IWComposeToolbarButtonType;

@protocol IWComposeToolbarDelegate <NSObject>

@optional
-(void)composeToolbar:(IWComposeToolbar *)toolbar didClickedButton:(IWComposeToolbarButtonType)buttonType;

@end
@interface IWComposeToolbar : UIView
@property(weak, nonatomic) id<IWComposeToolbarDelegate> delegate;
@end
