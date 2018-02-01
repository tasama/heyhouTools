//
//  NSURL+HHQiniuThumbnail.m
//  PersonShow
//
//  Created by heyhou on 17/3/20.
//  Copyright © 2017年 Jude. All rights reserved.
//

#import "NSURL+HHQiniuThumbnail.h"

@implementation NSURL (HHQiniuThumbnail)
- (NSURL *)thumbnailUrl:(CGRect)frame
{
    NSString *absoluStr = self.absoluteString;
    if ([absoluStr rangeOfString:@"imageMogr2"].location != NSNotFound) {
        return self;
    }
    if ([absoluStr rangeOfString:@"res.heyhou.com"].location == NSNotFound) {
        return self;
    }
    
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *urlStr = [NSString stringWithFormat:@"%@?imageMogr2/auto-orient/thumbnail/%0.fx/format/jpg", absoluStr, frame.size.width * scale];
    return [NSURL URLWithString:urlStr];
}
@end
