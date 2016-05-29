//
//  IWComposePhotosView.m
//  ItcastWeibo
//
//  Created by kaiyi on 16-5-28.
//  Copyright (c) 2016年 itcast. All rights reserved.
//

#import "IWComposePhotosView.h"

@implementation IWComposePhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/**
 * 添加图片
 */
-(void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    
    imageView.image = image;
    [self addSubview:imageView];
}

// View 整体图片View的布局

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = self.subviews.count;
    
    CGFloat imageViewW = 60;
    CGFloat imageViewH = 60;
    int maxColumns = 4;  // 一行最多显示4张图片
    
    // 计算图片的间距
    CGFloat margin = (self.frame.size.width - maxColumns * imageViewW) / (maxColumns + 1);
    
    
    // 计算每个图片排列的位置如九宫格, i表示行号
    for(int i = 0; i < count; i++){
        UIImageView *imageView = self.subviews[i];
        
        CGFloat imageViewX = margin + (i % maxColumns) * (imageViewW + margin);
        CGFloat imageViewY = (i / maxColumns) * (imageViewH + margin);
        
        
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    }
    
}

#pragma mark 返回总的图片
-(NSArray *)totalImages
{
    NSMutableArray *images = [NSMutableArray array];
    
    for(UIImageView *imageView in  self.subviews){
        [images addObject:imageView.image];
    }
    
    return images;
}

@end
