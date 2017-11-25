//
//  MacroFunction.m
//  wanglzStytle
//
//  Created by bhqm on 2017/11/9.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import "MacroFunction.h"

@implementation MacroFunction
// 转换成时天分秒
+ (NSString *)timeFormatted:(int)totalSeconds
{
    
    int day = (int)totalSeconds / (24 * 3600);
    int hours =  (int)totalSeconds / 3600 % 24;
    int minutes =  (int)(totalSeconds - day * 24 * 3600 - hours * 3600) / 60;
    int seconds = (int)(totalSeconds - day * 24 * 3600 - hours * 3600 - minutes*60);
    
    NSString *str;
    if (day != 0) {
        str = [NSString stringWithFormat:@"%02d天%02d时%02d分%02d秒",day,hours,minutes,seconds];
    }else if (day==0 && hours != 0) {
        str = [NSString stringWithFormat:@"%02d时%02d分%02d秒",hours,minutes,seconds];
    }else if (day== 0 && hours == 0 && minutes!=0) {
        str = [NSString stringWithFormat:@"%02d分%02d秒",minutes,seconds];
    }else{
        str = [NSString stringWithFormat:@"%02d秒",seconds];
    }
    
    return str;
}

@end
