//
//  IWFormData.h
//  ItcastWeibo
//
//  Created by kaiyi on 16-5-31.
//  Copyright (c) 2016年 itcast. All rights reserved.
//  封装需要上传的文件数据

#import <Foundation/Foundation.h>

@interface IWFormData : NSObject

/**
 *  文件数据
 */
@property (nonatomic, strong)NSData *data;

/**
 * 参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 * 文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 * 文件类型
 */
@property (nonatomic, copy) NSString *mimeType;



@end
