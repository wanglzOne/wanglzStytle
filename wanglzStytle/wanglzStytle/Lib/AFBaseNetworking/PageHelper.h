//
//  PageHelper.h
//  CrudeOilThrough
//
//  Created by Apple on 2017/9/11.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageHelper : NSObject
{
    int ps;
}
@property (nonatomic, assign) int currentPage;//当前页

@property (nonatomic, assign) int pageSize;//每页显示数据条数

@property (nonatomic, assign) int total;//总数据条数

@property (nonatomic, strong) NSDictionary *params;//字典参数(穿个服务器的)

- (void)add;//页数++

- (void)falseAdd;//页数--

@end
