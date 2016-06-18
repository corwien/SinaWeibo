//
//  IWComposePhotosView.m
//  ItcastWeibo
//
//  Created by apple on 14-5-19.
//  Copyright (c) 2014年 itcast. All rights reserved.
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

- (void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = self.subviews.count;
    CGFloat imageViewW = 70;
    CGFloat imageViewH = imageViewW;
    int maxColumns = 4; // 一行最多显示4张图片
    CGFloat margin = (self.frame.size.width - maxColumns * imageViewW) / (maxColumns + 1);
    for (int i = 0; i<count; i++) {
        UIImageView *imageView = self.subviews[i];
        
        CGFloat imageViewX = margin + (i % maxColumns) * (imageViewW + margin);
        CGFloat imageViewY = (i / maxColumns) * (imageViewH + margin);
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    }
}

- (NSArray *)totalImages
{
    NSMutableArray *images = [NSMutableArray array];
    
    for (UIImageView *imageView in self.subviews) {
        [images addObject:imageView.image];
    }
    
    return images;
}

@end
