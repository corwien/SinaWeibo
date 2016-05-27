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
        
        // 1.设置工具条背景图片，平铺
      self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
       // self.backgroundColor = [UIColor redColor];
        
        // 2.添加按钮
        
         [self addButtonWithIcon:@"compose_camerabutton_background" highIcon:@"compose_camerabutton_background_highlighted" tag:IWComposeToolbarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture" highIcon:@"compose_toolbar_picture_highlighted" tag:IWComposeToolbarButtonTypePicture];
         [self addButtonWithIcon:@"compose_mentionbutton_background" highIcon:@"compose_mentionbutton_background_highlighted" tag:IWComposeToolbarButtonTypeMention];
        
         [self addButtonWithIcon:@"compose_trendbutton_background" highIcon:@"compose_trendbutton_background_highlighted" tag:IWComposeToolbarButtonTypeTrend];
         [self addButtonWithIcon:@"compose_emoticonbutton_background" highIcon:@"compose_emoticonbutton_background_highlighted" tag:IWComposeToolbarButtonTypeEmotion];
        
    }
    return self;
    //
}


/**
 *
 * 添加按钮
 */
-(void)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(int)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    [self addSubview:button];
}

/**
 *
 * 监听按钮点击
 */
-(void)buttonClick:(UIButton *)button{
    
    // NSLog(@"%d", button.tag);
    
    if([self.delegate respondsToSelector:@selector(composeToolbar:didClickedButton:)])
    {
        [self.delegate composeToolbar:self didClickedButton:button.tag];
        
    }
    
}


/**
 *
 *
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    for(int i = 0; i < self.subviews.count; i++){
        UIButton *button = self.subviews[i];
        CGFloat buttonX = buttonW * i;
        button.frame = CGRectMake(buttonX, 0, buttonW, buttonH);
        
    }
}


@end
