//
//  IWHttpTool.m
//  ItcastWeibo
//
//  Created by kaiyi on 16-5-29.
//  Copyright (c) 2016年 itcast. All rights reserved.
//

#import "IWHttpTool.h"
#import "AFNetworking.h"

@implementation IWHttpTool

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray: (NSArray *)formDataArray  success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // AFNetworking\AFN
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送请求
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> totalFormData) {
        
        for(IWFormData *formData in formDataArray)
        {
            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
            
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success){
            success(responseObject);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if(failure){
            failure(error);
        }

    }];
}


+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送请求
    [mgr GET:url parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         if (success) {
             success(responseObject);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}
@end

/**
 *  用来封装文件数据的模型
 */
@implementation IWFormData

@end
