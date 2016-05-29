//
//  IWComposePhotosView.h
//  ItcastWeibo
//
//  Created by kaiyi on 16-5-28.
//  Copyright (c) 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWComposePhotosView : UIView

// 添加图片
-(void)addImage:(UIImage *)image;


/**
 * 返回内部所有的图片
 */
-(NSArray *)totalImages;
@end
