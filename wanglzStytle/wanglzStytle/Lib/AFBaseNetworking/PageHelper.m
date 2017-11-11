//
//  PageHelper.m
//  CrudeOilThrough
//
//  Created by Apple on 2017/9/11.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import "PageHelper.h"

@implementation PageHelper

//初始化
- (id)init
{
    if (self = [super init]) {
        ps = 10;
        self.currentPage = 1;
        self.pageSize  = ps;
        self.total = self.currentPage * self.pageSize;
    }
    return self;
}

//当前页显示数据条数
- (int)total
{
    return self.total = self.currentPage * self.pageSize;
}
//页数加一
- (void)add
{
    self.currentPage++;
    self.pageSize = ps;
}
//页数减一
- (void)falseAdd
{
    if (self.currentPage > 1) {
        self.currentPage--;
    }
    self.pageSize = ps;
}
//给服务器传currentPage和pageSize的字典
- (NSDictionary *)params
{
    return @{@"currentPage" : @(self.currentPage),
             @"pageSize" : @(self.pageSize)};
}

@end
