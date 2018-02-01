//
//  NSString+XRKUtils.h
//  YueDu
//
//  Created by Roy on 14/11/13.
//  Copyright (c) 2014年 Xiangrikui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XRKUtils)

+ (BOOL)isMobileNumber:(NSString *)mobileNum ;
- (BOOL)myContainsString:(NSString*)other;

//判断是否为空或者空格字符串
+ (BOOL)isNilString:(NSString *)string;

//获取去掉所有空格后的字符串
- (NSString *)stringRemoveBlank;

//md5 32位加密
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString;

//判断字符串是否为空字符
+ (BOOL) isBlankString:(NSString *)string;

// 计算字符串内包含多少mathStr子串
- (NSUInteger)numberOfMathesWithString:(NSString *)mathStr;

// 计算字符串内包含多少个大写字符
- (NSUInteger)numberOfUpperChar;

// 计算字符串内包含多少个非字母
- (NSUInteger)numberOfNotAlpha;

+ (BOOL)PureLetters:(NSString *)str;

+ (BOOL)isPureNumandCharacters:(NSString *)string;
@end
