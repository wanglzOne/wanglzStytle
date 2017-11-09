//
//  NSDate+Extension.h
//  wanglzStytle
//
//  Created by bhqm on 2017/11/9.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)


- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)hour;
- (NSInteger)weekday;

- (NSString *)toSecondEndingString;
+ (NSDate *)dateFromSecondEndingString:(NSString *)dateString;

- (NSString *)toMillionSecondEndingString;
+ (NSDate *)dateFromMillionSecondEndingString:(NSString *)dateString;

- (NSString *)toYearMonthDayString;
- (NSString *)toYearMonthDayString2;
+ (NSDate *)dateFromYearMonthDayEndingString:(NSString *)dateString;

- (NSString *)toMinutesEndingString;

- (NSString *)toMonthDayString;

- (NSString *)toMonthDayString2;

- (NSString *)toHourSecondString;

- (NSDate *)addOtherDay:(NSInteger)num;
///**
// 将服务器返回的UTC时间数据转化为NSDate
// */
//+ (NSDate *)dateWithTimeFromUTC:(NSTimeInterval)time;
/**
 *  将utc时间 计算时区的差值返回的毫秒数   date到1970的时间毫秒数
 *
 *  @return <#return value description#>
 */
- (NSTimeInterval)timeIntervalSince1970UTC;

/**
 *  得到 一个时间字符穿 @"yyyy-MM-dd HH:mm:ss"  相差 固定秒数的 时间字符串
 *
 *  @param datastr  "yyyy-MM-dd HH:mm:ss" 格式的时间 字符串
 *  @param interval 带符号的 相差的秒数
 *
 *  @return "yyyy-MM-dd HH:mm:ss" 格式字符串
 */
//+ (NSString *)datastring:(NSString *)datastr intervalTie:(NSTimeInterval)interval;

///获取当前 时间  到0:00的秒数
//+ (NSTimeInterval)geiNewTimefromeZero;


//@"yyyy-MM-dd HH:mm:ss:SSS"
/**
 *  将 北京时间字符串  转化为 上传给服务器的 utc 时间 （秒数）
 *
 *  @param dateString    时间字符串
 *  @param dateFormatStr yyyy-MM-dd HH:mm:ss:SSS
 *
 *  @return 上传给服务器的 utc 时间 （秒数）
 */
+  (NSTimeInterval)localTimeToUTCTimedateString:(NSString*)dateString NSDateFormatter:(NSString *)dateFormatStr;


/**
 *  MY 将 服务器 返回过来的 utc时间（int 秒数） 转化为想要的时间
 *
 *  @param dateFormatStr @"yyyy-MM-dd HH:mm"  格式
 *  @param utcTime       utc时间 （秒数）
 *
 *  @return 时间字符串
 */
+ (NSString *)getUTCTimeToLocaDatewith:(NSString *)dateFormatStr with:(NSTimeInterval)utcTime;

/**
 *  服务器  返回 过来的 时间戳  无时区区分
 *  wanglz getTime
 *
 *  @param dateFormatStr @"yyyy-MM-dd HH:mm:ss"
 *  @param time       time 秒
 *
 *  @return <#return value description#>
 */
+ (NSString *)getTimeToLocaDatewith:(NSString *)dateFormatStr with:(NSTimeInterval)time;


- (NSString *)getDataStrForDateFormatter:(NSString *)dateFormatStr;

///将 普通的 秒数转化为  HH:mm:ss
//+ (NSString *)getHHMMSS:(NSInteger )info;
//+ (NSString *)getnormarlTimeToLocaDatewith:(NSString *)dateFormatStr withnormal:(NSTimeInterval)normalTime;
/**
 *  比较两个nsdate的大小
 *
 *  @param oneDay     <#oneDay description#>
 *  @param anotherDay <#anotherDay description#>
 *
 *  @return 返回1表示oneDay是将来的时间  -1相反，   0表示时间相同
 */
//+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;
/**
 *  获得现在的时间
 *
 *  @param formatterStr 时间格式
 *
 *  @return
 */
//+ (NSString*)getNewTimeStrWithNSDateFormatter:(NSString*)formatterStr;
/**
 *  获得周几  这个月的 第几周  今年的第几周
 *
 *  @return <#return value description#>
 */
+ (NSString *)getWeekDay;
- (NSString*)getWeekDay;

- (NSString*)dateyyyy;
- (NSString*)dateMM;
- (NSString*)datedd;
- (NSString*)dateHH;
- (NSString*)datemm;
//- (NSString*)dateStr;
- (NSString *)dateyMdStr;



/**
 *  将时间 字符串  转化为 想要的 类型字符串
 *
 *  @param formatter  "yyyy-MM-dd HH:mm:ss:SSS"
 *  @param dateString 时间字符串
 *
 *  @return <#return value description#>
 */
+ (NSDate*)dateNSDateFormatter:(NSString *)formatter dateString:(NSString*)dateString;
/**
 *  将时间字符串 转化为  自己想要的字符串
 *
 *  @param formatter  yyyy-MM-dd HH:mm:ss
 *  @param dateString dateString
 *
 *  @return dateString
 */
+ (NSString*)datechangeforFormatter:(NSString *)formatter dateString:(NSString*)dateString;

/**
 *  通过 时间 间隔 计算出 间隔多少天 多少小时 多少分钟
 *
 *  @param time 时间  间隔的秒数
 *
 *  @return <#return value description#>
 */
+ (NSString *)getInterval:(int)time;


///是否是周末
- (BOOL)isWeekend;
///获得在这个时间段内有多少的天数
+ (NSInteger)getWeekend:(NSDate *)data1 andWeekend:(NSDate *)data2;

@end
