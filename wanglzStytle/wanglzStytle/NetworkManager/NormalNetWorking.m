//
//  NormalNetWorking.m
//  CrudeOilThrough
//
//  Created by Apple on 2017/9/11.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import "NormalNetWorking.h"
#import "AFBaseNetWorking.h"

@implementation NormalNetWorking

+ (void)post:(NSString *)urlPath
      params:(NSDictionary *)params
onDictCompletion:(NetWorkingBlockDictCompletion)blockDictCompletion
{
    AFBaseNetWorking *af = [[AFBaseNetWorking alloc] init];
    [af.manager POST:[urlPath url_ex] parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject;
        if ([responseObject isKindOfClass:[NSData class]]) {
            
            dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        
        if ([dict isKindOfClass:[NSDictionary class]]) {
            int code = dict[@"responseCode"] != (id)kCFNull ? [dict[@"responseCode"] intValue] : -1;
            if (code >= 0) {
                blockDictCompletion(dict,nil);
                
            }
            else
            {
                blockDictCompletion(dict,[NSError errorWithDomain:([dict[@"responseDescription"] isKindOfClass:[NSString class]] ? dict[@"responseDescription"] : @"数据异常") code:code userInfo:nil]);
            }
        }
        else
        {
            blockDictCompletion(nil,[NSError errorWithDomain:@"数据异常" code:-1 userInfo:nil]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error.code == -1001) {
            error = [NSError errorWithDomain:@"连接超时" code:error.code userInfo:nil];
        }
        if ([error.domain isEqualToString:@"NSCocoaErrorDomain"] || [error.domain isEqualToString:@"NSURLErrorDomain"]) {
            error = [NSError errorWithDomain:@"NSCocoaErrorDomain" code:error.code userInfo:nil];
        }
        
        blockDictCompletion(nil,error);
    }];
    
}

//get

+(void)get:(NSString *)urlPath params:(NSDictionary *)params onDictCompletion:(NetWorkingBlockDictCompletion)blockDictCompletion{
    AFBaseNetWorking *af = [[AFBaseNetWorking alloc] init];
    [af.manager GET:[urlPath url_ex] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject;
        if ([responseObject isKindOfClass:[NSData class]]) {
            
            dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        
        if ([dict isKindOfClass:[NSDictionary class]]) {
            int code = dict[@"responseCode"] != (id)kCFNull ? [dict[@"responseCode"] intValue] : -1;
            if (code >= 0) {
                blockDictCompletion(dict,nil);
                
            }
           else
            {
                blockDictCompletion(dict,[NSError errorWithDomain:([dict[@"responseDescription"] isKindOfClass:[NSString class]] ? dict[@"responseDescription"] : @"数据异常") code:code userInfo:nil]);
            }
        }
        else
        {
            blockDictCompletion(nil,[NSError errorWithDomain:@"数据异常" code:-1 userInfo:nil]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error.code == -1001) {
            error = [NSError errorWithDomain:@"连接超时" code:error.code userInfo:nil];
        }
        if ([error.domain isEqualToString:@"NSCocoaErrorDomain"] || [error.domain isEqualToString:@"NSURLErrorDomain"]) {
            error = [NSError errorWithDomain:@"请求失败,请重试..." code:error.code userInfo:nil];
        }
        
        blockDictCompletion(nil,error);
    }];
    

}


@end
