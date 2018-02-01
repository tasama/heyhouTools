//
//  NSString+pinyin.m
//  FunnyTicket
//
//  Created by tasama on 16/10/15.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "NSString+pinyin.h"
#import "HHMarco.h"

@implementation NSString (pinyin)

- (NSString *)firstCharactor {
    
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:self];
    
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformToLatin, false);
    NSString *pinyinString = [str stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    //转化为大写拼音
    NSString *pinYin = [[self polyphoneStringPinyinString:pinyinString] uppercaseString];
    
    // 截取大写首字母
    NSString *firstString = pinYin.copy;
    if (pinYin.length > 1) {
        
        firstString = [pinYin substringToIndex:1];
    }
    // 判断姓名首位是否为大写字母
    NSString * regexA = @"^[A-Z]$";
    NSPredicate *predA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexA];
    // 获取并返回首字母
    return [predA evaluateWithObject:firstString] ? firstString : @"#";
}

- (BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

/**
 多音字处理
 */
- (NSString *)polyphoneStringPinyinString:(NSString *)pinyinString
{
    if ([self hasPrefix:@"长"]) { return @"chang";}
    if ([self hasPrefix:@"沈"]) { return @"shen"; }
    if ([self hasPrefix:@"厦"]) { return @"xia";  }
    if ([self hasPrefix:@"地"]) { return @"di";   }
    if ([self hasPrefix:@"重"]) { return @"chong";}
    return pinyinString;
}


- (NSString *)allFirstCharactor {
    
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:self];

    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformToLatin, false);
    NSString *pinyinString = [str stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    NSString *pinYin = [[self polyphoneStringPinyinString:pinyinString] uppercaseString];

    NSArray *arrString = [pinYin componentsSeparatedByString:@" "];
    
    NSMutableString *allString = @"".mutableCopy;
    
    if ([arrString count] > 1) {
        
        for (NSString *str in arrString) {

            [allString appendString:str];
        }
    } else {
        
        [allString appendString:arrString.firstObject];
    }
    //获取并返回首字母
    return allString.copy;
}

- (NSString *)allFirstSingleCharactor {
    
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:self];
    
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformToLatin, false);
    NSString *pinyinString = [str stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    NSString *pinYin = [[self polyphoneStringPinyinString:pinyinString] uppercaseString];

    NSArray *arrString = [pinYin componentsSeparatedByString:@" "];
    
    NSMutableString *allString = @"".mutableCopy;
    
    if ([arrString count] > 1) {
        
        for (NSString *str in arrString) {
            
            [allString appendString:str.firstCharactor];
        }
    } else {
        
        NSString *firstSting = arrString.firstObject;
        
        if (!kStringIsEmpty(firstSting)) {
            [allString appendString:firstSting.firstCharactor];
        }
    }
    //获取并返回首字母
    return allString.copy;
}

- (BOOL)isLetter {
    
    if ([self characterAtIndex:0] <= 90 && [self characterAtIndex:0] >= 65) {
        
        return YES;
    } else {
        return NO;
    }
}

@end
