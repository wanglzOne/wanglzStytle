//
//  MacroFunction.h
//  wanglzStytle
//
//  Created by bhqm on 2017/11/9.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MacroFunction : NSObject


/**
 <#Description#>

 @param totalSeconds 总共多少秒
 @return 返回 天 时 分 秒
 */
+ (NSString *)timeFormatted:(int)totalSeconds;

@end
