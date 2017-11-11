//
//  AFBaseNetWorking.m
//  CrudeOilThrough
//
//  Created by Apple on 2017/9/11.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import "AFBaseNetWorking.h"

#define kServer_HttpTimeOut 15.0

@implementation AFBaseNetWorking

@synthesize manager;

//创建单例
+ (instancetype)shard{
    static id _manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

- (id)init{
    self = [super init];
    if (self) {
        manager = [AFHTTPSessionManager manager];
        //传入 json 格式数据
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [manager.requestSerializer setTimeoutInterval:kServer_HttpTimeOut];
        AFJSONResponseSerializer *jsonConfig = [AFJSONResponseSerializer serializer];
        manager.responseSerializer = jsonConfig;
        
        //设置返回类型
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html",@"Type-Text",@"text/plain", nil];
    }
    return self;
}

- (id)initWitBaseUrl:(NSString *)baseUrl{
    self = [super init];
    if (self) {
        manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:baseUrl]];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
        [manager.requestSerializer setTimeoutInterval:kServer_HttpTimeOut];
        
        AFJSONResponseSerializer *jsonConfig = [AFJSONResponseSerializer serializer];
        //        jsonConfig.removesKeysWithNullValues = YES; //移除为Null的字段
        manager.responseSerializer = jsonConfig;
    }
    
    return self;
}

-(void)post:(NSString *)url
     params:(NSDictionary *)params
   progress:(NSProgressBlock)uploadProgressBlock
onCompletion:(CommonBlockDictionary)completionCallback
    onError:(CommonBlockError)errorCallback{
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (uploadProgressBlock) {
            uploadProgressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = responseObject;
        if ([responseObject isKindOfClass:[NSData class]]) {
            dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        completionCallback(dict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        errorCallback(error);
    }];
}

- (void)post:(NSString *)url
      params:(NSDictionary *)params
    progress:(NSProgressBlock)uploadProgressBlock
responseObject:(CommonBlockCompletion)completionCallback
     onError:(CommonBlockError)errorCallback
{
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        if (uploadProgressBlock) {
            uploadProgressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id data = responseObject;
        if ([url containsString:@"queryMore"]) {
        }
        
        if ([responseObject isKindOfClass:[NSData class]]) {
            
            data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        if (completionCallback) {
            completionCallback(data);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (errorCallback) {
            errorCallback(error);
        }
    }];
}

- (void)get:(NSString *)url
     params:(NSDictionary *)params
responseObject:(CommonBlockCompletion)completionCallback
    onError:(CommonBlockError)errorCallback
{
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionCallback(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorCallback(error);
    }];
}

- (void)get:(NSString *)url
     params:(NSDictionary *)params
onCompletion:(CommonBlockDictionary)completionCallback
    onError:(CommonBlockError)errorCallback
{
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = responseObject;
        if ([responseObject isKindOfClass:[NSData class]]) {
            dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        if ([dict isKindOfClass:[NSDictionary class]]) {
            completionCallback(dict);
        }
        else
        {
            NSError *error = [NSError errorWithDomain:@"数据错误" code:-1 userInfo:nil];
            errorCallback(error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorCallback(error);
    }];
}

- (void)upImage:(NSString *)url
         params:(NSDictionary *)params
         images:(NSArray *)imageArray
       progress:(NSProgressBlock)uploadProgressBlock
   onCompletion:(CommonBlockDictionary)completionCallback
        onError:(CommonBlockError)errorCallback
{
    
    NSMutableArray* compressedArray = [NSMutableArray array];
    
    for (int index = 0;index < imageArray.count;index ++)
    {
        
        id image = [imageArray objectAtIndex:index];
        if([image isKindOfClass:[UIImage class]])
        {
            UIImage * uploadImage = image;
            if (uploadImage.size.width > 1024 || uploadImage.size.height > 1024){
            uploadImage = [image compressedImage];
            [compressedArray addObject:[uploadImage compressedData]];
           }
        }
        else
        {
            [compressedArray addObject:image];
        }
        
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:params];
    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        int i = 1;
        for (NSData* imageData in compressedArray) {
            NSString* str = [NSString stringWithFormat:@"%d.jpeg", i];
            [formData appendPartWithFileData:imageData
                                        name:@"file"
                                    fileName:str
                                    mimeType:@"image/jpeg"];//@"image/jpeg"
            i++;
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (uploadProgressBlock) {
            uploadProgressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = responseObject;
        if ([responseObject isKindOfClass:[NSData class]]) {
            dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        if ([dict isKindOfClass:[NSDictionary class]]) {
            completionCallback(dict);
        }
        else
        {
            NSError *error = [NSError errorWithDomain:@"数据错误" code:-1 userInfo:nil];
            errorCallback(error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorCallback(error);
    }];
}


+ (void)postRequestByServiceUrl:(NSString *)service
                         andApi:(NSString *)api
                      andParams:(NSDictionary *)params
                    andCallBack:(void (^)(id obj))callback
{
    NSString *basePath = [service stringByAppendingString:api];
    NSURL *url = [NSURL URLWithString:basePath];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *body = [self dealWithParam:params];
    NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    // 设置请求体
    [request setHTTPBody:bodyData];
    // 设置本次请求的提交数据格式
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    // 设置本次请求请求体的长度(因为服务器会根据你这个设定的长度去解析你的请求体中的参数内容)
    [request setValue:[NSString stringWithFormat:@"%ld",bodyData.length] forHTTPHeaderField:@"Content-Length"];
    // 设置本次请求的最长时间
    request.timeoutInterval = 20;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (dic) {
                callback(dic);
            }else
            {
                callback(error.description);
            }
        }
    }];
    
    [task resume];
}

+ (void)getRequestByServiceUrl:(NSString *)service
                        andApi:(NSString *)api
                     andParams:(NSDictionary *)params
                   andCallBack:(void (^)(id obj))callback
{
    NSString *basePath = [service stringByAppendingString:api];
    NSString *urlString = [NSString string];
    // 因为参数是以字典的形式传进来的，所以用了一个 dealWithParam 方法拼接参数。
    if (params) {
        NSString *paramStr =  [self dealWithParam:params];
        urlString = [basePath stringByAppendingString:paramStr];
    }else
    {
        urlString = basePath;
    }
    NSString *pathStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:pathStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (dic) {
                callback(dic);
            }else
            {
                callback(error.description);
            }
        });
    }];
    
    [task resume];
}

+ (NSString *)dealWithParam:(NSDictionary *)param
{
    NSArray *allkeys = [param allKeys];
    NSMutableString *result = [NSMutableString string];
    for (NSString *key in allkeys) {
        
        NSString *str = [NSString stringWithFormat:@"%@=%@&",key,param[key]];
        [result appendString:str];
    }
    
    return [result substringWithRange:NSMakeRange(0, result.length-1)];
}



@end
