//
//  NormalNetWorking.h
//  CrudeOilThrough
//
//  Created by Apple on 2017/9/11.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^NetWorkingBlockDictCompletion)(NSDictionary *responseDict, NSError *error);//返回字典的block

@interface NormalNetWorking : NSObject

//基础请求

//POST
+ (void)post:(NSString *)urlPath
      params:(NSDictionary *)params
onDictCompletion:(NetWorkingBlockDictCompletion)blockDictCompletion;

//GET
+ (void)get:(NSString *)urlPath
      params:(NSDictionary *)params
onDictCompletion:(NetWorkingBlockDictCompletion)blockDictCompletion;


@end
