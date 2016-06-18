//
//  IWComposePhotosView.h
//  ItcastWeibo
//
//  Created by apple on 14-5-19.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWComposePhotosView : UIView
/**
 *  添加一张新的图片
 */
- (void)addImage:(UIImage *)image;

/**
 *  返回内部所有的图片
 */
- (NSArray *)totalImages;
@end
