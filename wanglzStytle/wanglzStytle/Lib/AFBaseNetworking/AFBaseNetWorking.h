//
//  AFBaseNetWorking.h
//  CrudeOilThrough
//
//  Created by Apple on 2017/9/11.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "NSString+UrlExtension.h"
#import "UIImage+Compress.h"
#import "PageHelper.h"

typedef void(^CommonBlockCompletion)(id responseObject);//返回id 类型结果 block
typedef void(^CommonBlockDictionary)(NSDictionary *dic);//返回字典类型结果 block
typedef void(^CommonBlockError)(NSError *error);// 返回错误 block

typedef void (^NSProgressBlock)(NSProgress *uploadProgress);

//AFNetworking
@interface AFBaseNetWorking : NSObject

@property (nonatomic, readonly, getter = manager) AFHTTPSessionManager *manager;

- (id)initWitBaseUrl:(NSString *)baseUrl;

//返回字典结果
- (void)post:(NSString *)url
      params:(NSDictionary *)params
    progress:(NSProgressBlock)uploadProgressBlock
onCompletion:(CommonBlockDictionary)completionCallback
     onError:(CommonBlockError)errorCallback;

//返回 id 对象结果
- (void)post:(NSString *)url
      params:(NSDictionary *)params
    progress:(NSProgressBlock)uploadProgressBlock
responseObject:(CommonBlockCompletion)completionCallback
     onError:(CommonBlockError)errorCallback;

//处理GET请求  返回 id 对象结果
- (void)get:(NSString *)url
     params:(NSDictionary *)params
responseObject:(CommonBlockCompletion)completionCallback
    onError:(CommonBlockError)errorCallback;

// 返回经过解析的 数据字典
- (void)get:(NSString *)url
     params:(NSDictionary *)params
onCompletion:(CommonBlockDictionary)completionCallback
    onError:(CommonBlockError)errorCallback;

//上传图片
- (void)upImage:(NSString *)url
         params:(NSDictionary *)params
         images:(NSArray *)imageArray
       progress:(NSProgressBlock)uploadProgressBlock
   onCompletion:(CommonBlockDictionary)completionCallback
        onError:(CommonBlockError)errorCallback;


@end
