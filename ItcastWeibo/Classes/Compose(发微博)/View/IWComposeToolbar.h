//
//  IWComposeToolbar.h
//  ItcastWeibo
//
//  Created by apple on 14-5-19.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IWComposeToolbar;

typedef enum {
    IWComposeToolbarButtonTypeCamera,
    IWComposeToolbarButtonTypePicture,
    IWComposeToolbarButtonTypeMention,
    IWComposeToolbarButtonTypeTrend,
    IWComposeToolbarButtonTypeEmotion
} IWComposeToolbarButtonType;

@protocol IWComposeToolbarDelegate <NSObject>
@optional
- (void)composeToolbar:(IWComposeToolbar *)toolbar didClickedButton:(IWComposeToolbarButtonType)buttonType;
@end

@interface IWComposeToolbar : UIView
@property (weak, nonatomic) id<IWComposeToolbarDelegate> delegate;
@end
