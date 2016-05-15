//
//  IWTextView.m
//  ItcastWeibo
//
//  Created by apple on 14-5-19.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWTextView.h"

@interface IWTextView()

@property (nonatomic,weak) UILabel *placeholderLabel;

@end

@implementation IWTextView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 1.添加文字提示
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.textColor = [UIColor lightGrayColor];
        placeholderLabel.hidden = YES;
        
        // 文本输入框，文字提示的label背景
        // placeholderLabel.backgroundColor = [UIColor orangeColor];
        placeholderLabel.numberOfLines = 0;   // 文字换行
        placeholderLabel.adjustsFontSizeToFitWidth = YES;
        
        [self insertSubview:placeholderLabel atIndex:0];
        
        // [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        
        // 2.******监听文字改变，是否隐藏placeholder******
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];   // 保存数据到模型
    
    self.placeholderLabel.text = placeholder;
    
    if(placeholder.length)    // 是否需要显示
    {
        self.placeholderLabel.hidden = NO;
        self.placeholderLabel.frame = self.bounds;
        
      
        // 计算frame，设置文字提示“分享新鲜事...”的显示位置
        CGFloat placeholderX = 5;   // 光标初始位置
        CGFloat placeholderY = 8;
        
        CGFloat maxH = self.frame.size.height;
        CGFloat maxW = self.frame.size.width;
        CGSize placeholderSize = [placeholder sizeWithFont:self.placeholderLabel.font constrainedToSize:CGSizeMake(maxW, maxH)];
        
        self.placeholderLabel.frame = CGRectMake(placeholderX, placeholderY, placeholderSize.width, placeholderSize.height);
       
        
    }else{
        self.placeholderLabel.hidden = YES;
    }
    
    self.placeholderLabel.hidden = (placeholder.length == 0);
}

// 设置文本框颜色
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholder = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

// 设置字体
-(void)setFont:(UIFont *)font{
    [super setFont:font]; // 调用系统的字体
    
    self.placeholderLabel.font = font;
    self.placeholder = self.placeholder;
}

-(void)textDidChange
{
    self.placeholderLabel.hidden = (self.text.length != 0);
    
}

-(void)dealloc
{
    // [NSNotificationCenter removeObserve:self];
}

@end
