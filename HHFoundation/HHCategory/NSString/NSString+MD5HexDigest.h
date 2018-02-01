//
//  NSString+MD5HexDigest.h
//  Heyhou
//
//  Created by XiaoZefeng on 23/9/16.
//  Copyright © 2016年 XiaoZefeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5HexDigest)

- (NSString *)md5HexDigest;
- (NSString *)escapeStr;

/**
 MD5处理
 */
- (NSString *)md5;

@end
