//
//  NSString+MD5HexDigest.m
//  Heyhou
//
//  Created by XiaoZefeng on 23/9/16.
//  Copyright © 2016年 XiaoZefeng. All rights reserved.
//

#import "NSString+MD5HexDigest.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5HexDigest)

- (NSString *)md5HexDigest
{
    
    const char *original_str = [self UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (unsigned int)strlen(original_str), result);
    
    NSMutableString *hash = [NSMutableString string];
    
    for (int i = 0; i < 16; i++)
        
        [hash appendFormat:@"%02X", result[i]];
    
    return [hash lowercaseString];
    
}

- (NSString *)escapeStr{
    NSString *strUrl = [self stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
    return strUrl;
}

- (NSString *)md5{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


@end
