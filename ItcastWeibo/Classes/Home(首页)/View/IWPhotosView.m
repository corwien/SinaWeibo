//
//  IWPhotosView.m
//  ItcastWeibo
//
//  Created by apple on 14-5-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWPhotosView.h"
#import "IWPhoto.h"
#import "IWPhotoView.h"

#define IWPhotoW 70
#define IWPhotoH 70
#define IWPhotoMargin 10

@implementation IWPhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化9个子控件
        for (int i = 0; i<9; i++) {
            IWPhotoView *photoView = [[IWPhotoView alloc] init];
            [self addSubview:photoView];
        }
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    for (int i = 0; i<self.subviews.count; i++) {
        // 取出i位置对应的imageView
        IWPhotoView *photoView = self.subviews[i];
        
        // 判断这个imageView是否需要显示数据
        if (i < photos.count) {
            // 显示图片
            photoView.hidden = NO;
            
//            IWPhoto *photo = photos[i];
            
            // 传递模型数据
            photoView.photo = photos[i];
            
            // 设置子控件的frame
            int maxColumns = (photos.count == 4) ? 2 : 3;
            int col = i % maxColumns;
            int row = i / maxColumns;
            CGFloat photoX = col * (IWPhotoW + IWPhotoMargin);
            CGFloat photoY = row * (IWPhotoH + IWPhotoMargin);
            photoView.frame = CGRectMake(photoX, photoY, IWPhotoW, IWPhotoH);
            
            // Aspect : 按照图片的原来宽高比进行缩
            // UIViewContentModeScaleAspectFit : 按照图片的原来宽高比进行缩放(一定要看到整张图片)
            // UIViewContentModeScaleAspectFill :  按照图片的原来宽高比进行缩放(只能图片最中间的内容)
            // UIViewContentModeScaleToFill : 直接拉伸图片至填充整个imageView
            
            if (photos.count == 1) {
                photoView.contentMode = UIViewContentModeScaleAspectFit;
                photoView.clipsToBounds = NO;
            } else {
                photoView.contentMode = UIViewContentModeScaleAspectFill;
                photoView.clipsToBounds = YES;
            }
        } else { // 隐藏imageView
            photoView.hidden = YES;
        }
    }
}

+ (CGSize)photosViewSizeWithPhotosCount:(int)count
{
    // 一行最多有3列
    int maxColumns = (count == 4) ? 2 : 3;
    
    //  总行数
    int rows = (count + maxColumns - 1) / maxColumns;
    // 高度
    CGFloat photosH = rows * IWPhotoH + (rows - 1) * IWPhotoMargin;
    
    // 总列数
    int cols = (count >= maxColumns) ? maxColumns : count;
    // 宽度
    CGFloat photosW = cols * IWPhotoW + (cols - 1) * IWPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
    /**
     一共60条数据 == count
     一页10条 == size
     总页数 == pages
     pages = (count + size - 1)/size;
     */
}
@end