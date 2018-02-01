//
//  NSString+XRKUtils.m
//  YueDu
//
//  Created by Roy on 14/11/13.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "NSString+XRKUtils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (XRKUtils)

- (BOOL)myContainsString:(NSString*)other {
    NSRange range = [self rangeOfString:other];
    return range.length != 0;
}

+ (BOOL)isNilString:(NSString *)string;
{
    if (!string)
        return YES;
    
    //去完空格判断长度
    NSString *str = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([str length] == 0)
        return YES;
    
    return NO;
}

#pragma -mark 判断字符串是否为空字符
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


//获取去掉所有空格后的字符串
- (NSString *)stringRemoveBlank
{
    NSString *resultStr = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    return resultStr;
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     * 未知：140、141、142、143、144、146、148、149、154
     * 4G号段：170：[1700(电信)、1705(移动)、1709(联通)]、176(联通)、177(电信)、178(移动)
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSString *specialPhoneRegex = @"^((14[0-9])|(15[0-9])|(17[0,0-9]))\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestunkonw = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", specialPhoneRegex];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextestunkonw evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


+ (NSString *)getMd5_32Bit_String:(NSString *)srcString{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH*1];
    // CC_MD5( cStr, strlen(cStr), digest ); 这里的用法明显是错误的，但是不知道为什么依然可以在网络上得以流传。当srcString中包含空字符（\0）时
    CC_MD5( cStr, (int)srcString.length, digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 1];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH*1; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}

- (NSUInteger)numberOfMathesWithString:(NSString *)mathStr
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:mathStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSUInteger numberOfMatchesLeft = [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])];
    
    return numberOfMatchesLeft;
}

- (NSUInteger)numberOfUpperChar
{
    NSUInteger count = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar c = [self characterAtIndex:i];
        if (isupper(c)) {
            count++;
        }
    }
    
    return count;
}

- (NSUInteger)numberOfNotAlpha
{
    NSUInteger count = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar c = [self characterAtIndex:i];
        if (!isalpha(c)) {
            count++;
        }
    }
    
    return count;
}

+ (BOOL)PureLetters:(NSString*)str{
    
    for(int i=0;i<str.length;i++){
        
        unichar c=[str characterAtIndex:i];
        
        if((c<'A'||c>'Z')&&(c<'a'||c>'z'))
            
            return NO;
        
    }
    
    return YES;
}

+ (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}

@end
