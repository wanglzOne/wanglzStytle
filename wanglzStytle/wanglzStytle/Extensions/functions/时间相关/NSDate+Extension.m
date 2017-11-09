//
//  NSDate+Extension.m
//  wanglzStytle
//
//  Created by bhqm on 2017/11/9.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)



- (NSInteger)year
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear fromDate:self];
    return [components year];
}

- (NSInteger)month
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear fromDate:self];
    return [components month];
}

- (NSInteger)day
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitDay fromDate:self];
    return [components day];
}

- (NSInteger)hour
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitHour fromDate:self];
    return [components hour];
}

- (NSInteger)weekday
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitWeekday fromDate:self];
    
    return [components weekday];
}

- (NSString*)toSecondEndingString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:self];
}
- (NSString *)getDataStrForDateFormatter:(NSString *)dateFormatStr
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormatStr];
    
    return [formatter stringFromDate:self];
}
+ (NSString *)datastring:(NSString *)datastr intervalTie:(NSTimeInterval)interval
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate*nowDate  = [formatter dateFromString:datastr];
    NSDate*date1 = [nowDate initWithTimeInterval:interval/1000.0 sinceDate:nowDate];
    return [formatter stringFromDate:date1];
}

+ (NSDate*)dateFromSecondEndingString:(NSString*)dateString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter dateFromString:dateString];
}

- (NSString*)toMillionSecondEndingString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    return [formatter stringFromDate:self];
}

+ (NSDate*)dateFromMillionSecondEndingString:(NSString*)dateString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    return [formatter dateFromString:dateString];
}

- (NSString*)toYearMonthDayString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:self];
}

- (NSString*)toYearMonthDayString2
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    return [formatter stringFromDate:self];
}

+ (NSDate*)dateFromYearMonthDayEndingString:(NSString*)dateString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter dateFromString:dateString];
}

- (NSString*)toMinutesEndingString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [formatter stringFromDate:self];
}

- (NSString*)toMonthDayString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月dd日"];
    return [formatter stringFromDate:self];
}

- (NSString*)toMonthDayString2
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"];
    return [formatter stringFromDate:self];
}

- (NSString*)toHourSecondString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    return [formatter stringFromDate:self];
}

- (NSDate*)addOtherDay:(NSInteger)num
{
    return [[NSDate date] initWithTimeInterval:num * 24 * 60 * 60 sinceDate:self];
}

+ (NSDate*)dateWithTimeFromUTC:(NSTimeInterval)time
{
    NSDate* d2 = [NSDate dateWithTimeIntervalSince1970:time/1000.0];

    return d2;
}
- (NSTimeInterval)timeIntervalSince1970UTC
{
    return [self timeIntervalSince1970]*1000;

}
+ (NSTimeInterval)geiNewTimefromeZero
{
    NSString*time = [[NSDate date] getDataStrForDateFormatter:@"HH:mm:ss"];
    NSInteger tt = 0;
    int i = 0;
    for (NSString *at in [time componentsSeparatedByString:@":"]) {
        int d = 1;
        if (i==0) {
            d = 3600;
        }else if (i == 1)
        {
            d = 60;
        }
        tt = tt + [at intValue]*d;
        i++;
    }
    return tt;
}
//@"yyyy-MM-dd HH:mm:ss:SSS"
+ (NSTimeInterval)localTimeToUTCTimedateString:(NSString*)dateString NSDateFormatter:(NSString*)dateFormatStr
{
    //yyyy-MM-dd HH:mm:ss
    
    //减去时区
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormatStr];
    NSDate* date = [formatter dateFromString:dateString];
    
    return [date timeIntervalSince1970] *1000.0;
}

//MY
+ (NSString*)getUTCTimeToLocaDatewith:(NSString*)dateFormatStr with:(NSTimeInterval)utcTime
{
    //加上 时区 才是 utc 时间
    NSDate* d2 = [NSDate dateWithTimeIntervalSince1970:utcTime/1000.0];

    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormatStr]; //yyyy-MM-dd HH:mm:ss
    
    return [formatter stringFromDate:d2];
}
//wanglz getTime
+ (NSString *)getTimeToLocaDatewith:(NSString *)dateFormatStr with:(NSTimeInterval)time
{
    NSDate* d2 = [NSDate dateWithTimeIntervalSince1970:time/1000.0];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormatStr];
    return [formatter stringFromDate:d2];
}

+ (NSString*)getHHMMSS:(NSInteger)info
{
    NSDate* localDate = [NSDate dateFromYearMonthDayEndingString:[[NSDate date] toYearMonthDayString]];
    NSDate* onedate = [[NSDate alloc] initWithTimeInterval:info sinceDate:localDate];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    return [formatter stringFromDate:onedate];
}
+ (NSString*)getnormarlTimeToLocaDatewith:(NSString*)dateFormatStr withnormal:(NSTimeInterval)normalTime
{
    NSDate* localDate = [NSDate dateFromYearMonthDayEndingString:[[NSDate date] toYearMonthDayString]];
    NSDate* onedate = [[NSDate alloc] initWithTimeInterval:normalTime sinceDate:localDate];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormatStr];
    return [formatter stringFromDate:onedate];
}

+ (int)compareOneDay:(NSDate*)oneDay withAnotherDay:(NSDate*)anotherDay
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString* oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString* anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate* dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate* dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    
    //{NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending};
    //    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending) {
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
}

- (NSString*)addOtherDate:(NSDate*)date
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"];

    
    return @"";
}

+ (NSString*)getNewTimeStrWithNSDateFormatter:(NSString*)formatterStr
{
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:formatterStr];
    return [formatter2 stringFromDate:date];
}

+ (NSString*)getWeekDay
{
    NSDate* date = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps;
    // 年月日获得
    comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitYear | NSCalendarUnitDay)
                        fromDate:date];
    /*
     NSInteger year = [comps year];
     NSInteger month = [comps month];
     NSInteger day = [comps day];
     //    NSLog(@"year: %d month: %d, day: %d", year, month, day);
     */
    //当前的时分秒获得
    comps = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond)
                        fromDate:date];
    /*
     NSInteger hour = [comps hour];
     NSInteger minute = [comps minute];
     NSInteger second = [comps second];
     //    NSLog(@"hour: %d minute: %d second: %d", hour, minute, second);
     */
    
    // 周几和星期几获得
    comps = [calendar components:(NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
                        fromDate:date];
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    /*
     NSInteger week = [comps weekOfYear]; // 今年的第几周
     NSInteger weekdayOrdinal = [comps weekOfMonth]; // 这个月的第几周[comps weekdayOrdinal]
     //    NSLog(@"week: %d weekday: %d weekday ordinal: %d", week, weekday, weekdayOrdinal);
     */
    
    NSString* weekDayStr;
    switch (weekday) {
        case 1:
            weekDayStr = @"星期天";
            break;
        case 2:
            weekDayStr = @"星期一";
            break;
        case 3:
            weekDayStr = @"星期二";
            break;
        case 4:
            weekDayStr = @"星期三";
            break;
        case 5:
            weekDayStr = @"星期四";
            break;
        case 6:
            weekDayStr = @"星期五";
            break;
        case 7:
            weekDayStr = @"星期六";
            break;
        default:
            break;
    }
    return weekDayStr;
}

- (NSString*)getWeekDay
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps;
    // 年月日获得
    comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitYear | NSCalendarUnitDay)
                        fromDate:self];
    /*
     NSInteger year = [comps year];
     NSInteger month = [comps month];
     NSInteger day = [comps day];
     //    NSLog(@"year: %d month: %d, day: %d", year, month, day);
     */
    //当前的时分秒获得
    comps = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond)
                        fromDate:self];
    /*
     NSInteger hour = [comps hour];
     NSInteger minute = [comps minute];
     NSInteger second = [comps second];
     //    NSLog(@"hour: %d minute: %d second: %d", hour, minute, second);
     */
    
    // 周几和星期几获得
    comps = [calendar components:(NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
                        fromDate:self];
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    /*
     NSInteger week = [comps weekOfYear]; // 今年的第几周
     NSInteger weekdayOrdinal = [comps weekOfMonth]; // 这个月的第几周[comps weekdayOrdinal]
     //    NSLog(@"week: %d weekday: %d weekday ordinal: %d", week, weekday, weekdayOrdinal);
     */
    
    NSString* weekDayStr;
    switch (weekday) {
        case 1:
            weekDayStr = @"周日";
            break;
        case 2:
            weekDayStr = @"周一";
            break;
        case 3:
            weekDayStr = @"周二";
            break;
        case 4:
            weekDayStr = @"周三";
            break;
        case 5:
            weekDayStr = @"周四";
            break;
        case 6:
            weekDayStr = @"周五";
            break;
        case 7:
            weekDayStr = @"周六";
            break;
        default:
            break;
    }
    return weekDayStr;
    
}

///是否是周末
- (BOOL)isWeekend
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps;
    comps = [calendar components:(NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
                        fromDate:self];
    NSInteger weekday = [comps weekday];
    if (weekday == 1 || weekday == 7) {
        return YES;
    }
    return NO;
}

- (NSInteger)weekendIndex
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps;
    comps = [calendar components:(NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
                        fromDate:self];
    return [comps weekday];
}

- (NSString *)dateyyyy
{
    return [self getDataStrForDateFormatter:@"yyyy"];
}
- (NSString *)dateMM
{
    return [self getDataStrForDateFormatter:@"MM"];
}
- (NSString *)datedd
{
    return [self getDataStrForDateFormatter:@"dd"];
}
- (NSString *)dateHH
{
    return [self getDataStrForDateFormatter:@"HH"];
}
- (NSString *)datemm
{
    return [self getDataStrForDateFormatter:@"mm"];
}
- (NSString *)dateStr
{
    return [self getDataStrForDateFormatter:@"yyyy-MM-dd HH:mm"];
}
- (NSString *)dateyMdStr
{
    return [self getDataStrForDateFormatter:@"yyyy-MM-dd"];
}


+ (NSDate*)dateNSDateFormatter:(NSString*)formatter dateString:(NSString*)dateString
{
    NSDateFormatter* dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:formatter]; //@"yyyy-MM-dd HH:mm:ss:SSS"
    return [dateformatter dateFromString:dateString];
}
+ (NSString*)datechangeforFormatter:(NSString*)formatter dateString:(NSString*)dateString
{
    NSDateFormatter* dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //@"yyyy-MM-dd HH:mm:ss"
    NSDate* ddd = [dateformatter dateFromString:dateString];
    NSDateFormatter* formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:formatter];
    NSString* dateStr2 = [formatter2 stringFromDate:ddd];
    return dateStr2;
}

//使用秒数计算时间间隔
+ (NSString*)getInterval:(int)time
{
    NSString* str;
    int tian = time / (24 * 60 * 60);
    int shengyu = time % (24 * 60 * 60);
    int xiaoshi = shengyu / 3600;
    int yu = shengyu % 3600;
    int fen = yu / 60;
    if (!tian) {
        if (xiaoshi) {
            str = [NSString stringWithFormat:@"%d小时%d分", xiaoshi, fen];
        }
        else {
            str = [NSString stringWithFormat:@"%d分", fen];
        }
    }
    else
        str = [NSString stringWithFormat:@"%d天 %d小时%d分", tian, xiaoshi, fen];
    return str;
}

+ (NSInteger)getWeekend:(NSDate *)date1 andWeekend:(NSDate *)date2
{
    NSMutableArray *dates = [[NSMutableArray alloc] init];;
    NSDate *date = date1;
    while (date <= date2) {
        [dates addObject:date];
        [date addOtherDay:1];
    }
    
    
    
    int i = 0;
    for (NSDate *d in dates) {
        if ([d isWeekend]) {
            i++;
        }
    }
    return i;
}

@end
