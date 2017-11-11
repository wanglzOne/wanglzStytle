//
//  UIImage+Property.m
//  CrudeOilThrough
//
//  Created by Apple on 2017/9/11.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import "UIImage+Property.h"

#import <objc/runtime.h>

@implementation UIImage (Property)

static const char* KImageSourceType = "ImageSourceType";
static const char* KWatermarkForTime = "WatermarkForTime";


- (UIImageSourceType)imageSourceType
{
    return [objc_getAssociatedObject(self, KImageSourceType) intValue];
}

- (void)setImageSourceType:(UIImageSourceType)imageSourceType
{
    objc_setAssociatedObject(self, KImageSourceType, [NSNumber numberWithInt:imageSourceType], OBJC_ASSOCIATION_ASSIGN);
}


- (BOOL)isWatermarkForTime
{
    return [objc_getAssociatedObject(self, KWatermarkForTime) boolValue];
}

- (void)setIsWatermarkForTime:(BOOL)isWatermarkForTime
{
    objc_setAssociatedObject(self, KWatermarkForTime, [NSNumber numberWithBool:isWatermarkForTime], OBJC_ASSOCIATION_ASSIGN);
}

@end
