//
//  NSDate+HHExtension.h
//  FunnyTicket
//
//  Created by heyhou on 16/11/7.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HHExtension)
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

/**
 *  传入一个标准时间戳字符串,得出一个距离当前时间的字符串
 *  时间展示“今天+具体时间，昨天+具体时间，其他显示月+日，不属于今年展示年月日”
 */
+ (NSString *)compareCureDate:(NSString *)dateStr;

/**
 *  字符串转换成日期
 *
 *  @param date 日期字符串
 *
 *  @return 日期
 */
+ (NSDate*)dateWithString:(NSString *)date;

/**
 *  获取当前日期，并将其转换成字符串
 *
 *  @return 字符串
 */
+ (NSString *)currentDateStr;

/**
 获取当前日期时间，并将其转换成字符串

 @return 字符串
 */
+ (NSString *)currentDateWithHourStr;

+ (NSString *)currentDateWithSecStr;

+ (NSString *)compareCurrentDateWithDateNum:(NSInteger )dateNum;

/**
 *
 * 把时间戳转换为时间字符串
 *  @return 字符串
 */
+ (NSString *)dateStringChangeFromDateNum:(NSInteger )dateNum;

/**
 *
 * 把时间戳转换为时间字符串
 *  @return 字符串
 */
+ (NSString *)dateStringChangeFromDateNum:(NSInteger )dateNum andFormat:(NSString *)format;

/**
 获取当前时间的时间戳

 @return 时间戳
 */
+ (NSString *)dateStringAboutCurrentTime;

+ (NSString *)dateStringAboutCurrentTimeWithFormat:(NSString *)format;

+ (long)dateLongAboutCurrentTime;

+ (NSString *)dataFormat:(NSString *)format time:(long long)time;
+ (NSString *)timestampToString:(long long)time;

@end
