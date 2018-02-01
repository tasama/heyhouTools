//
//  NSDate+HHExtension.m
//  FunnyTicket
//
//  Created by heyhou on 16/11/7.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "NSDate+HHExtension.h"

@implementation NSDate (HHExtension)

/**
 *  是否为今天
 */
- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}

/**
 *  是否为昨天
 */
- (BOOL)isYesterday
{
    // 2014-05-01
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    
    // 2014-04-30
    NSDate *selfDate = [self dateWithYMD];
    
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

- (NSDate *)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}

/**
 *  是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}

- (NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

+ (NSString *)compareCureDate:(NSString *)dateStr
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *date = [fmt dateFromString:dateStr];
    // 判断是否为今年
    if (date.isThisYear) {
        if (date.isToday) { // 今天
            fmt.dateFormat = @"今天 HH:mm";
            return [fmt stringFromDate:date];
        } else if (date.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:date];
        } else { // 至少是前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:date];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:date];
    }
}

+ (NSString *)compareCurrentDateWithDateNum:(NSInteger )dateNum
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateNum];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 判断是否为今年
    if (date.isThisYear) {
        if (date.isToday) { // 今天
            fmt.dateFormat = @"今天";
            return [fmt stringFromDate:date];
        } else if (date.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天";
            return [fmt stringFromDate:date];
        } else { // 至少是前天
            fmt.dateFormat = @"MM-dd";
            return [fmt stringFromDate:date];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:date];
    }
}

+ (NSString *)compareCurrentTimeWithDateNum:(NSInteger )dateNum
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateNum];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"HH:mm";
    return [fmt stringFromDate:date];
}

+ (NSString *)dateStringChangeFromDateNum:(NSInteger )dateNum
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateNum];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    return [fmt stringFromDate:date];
}

+ (NSString *)dateStringChangeFromDateNum:(NSInteger )dateNum andFormat:(NSString *)format;
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateNum];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = format;
    return [fmt stringFromDate:date];
}


+ (NSDate *)dateWithString:(NSString *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter dateFromString:date];
}

+ (NSString *)currentDateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]/*[NSDate alloc] internetDate]*/];
    return currentDateStr;
}

+ (NSString *)currentDateWithHourStr {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd.hh"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]/*[NSDate alloc] internetDate]*/];
    return currentDateStr;
}

+ (NSString *)currentDateWithSecStr {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd.hh.mm.ss"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]/*[NSDate alloc] internetDate]*/];
    return currentDateStr;
}

+ (NSString *)dateStringAboutCurrentTime {

    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeStamp =[date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", timeStamp];
    
    return timeString;
}

+ (NSString *)dateStringAboutCurrentTimeWithFormat:(NSString *)format
{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeStamp =[date timeIntervalSince1970];

    return [self dateStringChangeFromDateNum:timeStamp  andFormat:format];
}

+ (long)dateLongAboutCurrentTime {
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    long a = [dat timeIntervalSince1970] * 1000;
    return a;
}


+ (NSString *)dataFormat:(NSString *)format time:(long long)time {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return [formatter stringFromDate:date];
}

+ (NSString *)timestampToString:(long long)time{
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    return [formatter stringFromDate:date];
}

@end
