//
//  MacroStatic.m
//  wanglzStytle
//
//  Created by bhqm on 2017/11/9.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import "MacroStatic.h"

#ifdef DEBUG
NSString* const KBaseIP = @"11";
#else
NSString* const KBaseIP = @"111";
#endif

NSString* const KBaseKeyWord = @"/api/";
NSString* const kBaiduMapKey = @"";
NSString* const kGaodeMapKey = @"";//高德地图key
NSString* const KProductPhoneNumber = @"4000-000-000";

@implementation MacroStatic

@end
