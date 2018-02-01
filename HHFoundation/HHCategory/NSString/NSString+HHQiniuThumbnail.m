//
//  NSString+HHQiniuThumbnail.m
//  FunnyTicket
//
//  Created by heyhou on 17/3/17.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import "NSString+HHQiniuThumbnail.h"

@implementation NSString (HHQiniuThumbnail)

- (NSString *)thumbnailUrlStr:(HHThumbnailSize)size
{
    NSString *thumnailStr;
    switch (size) {
        case HHThumbnailSize_60:
            thumnailStr = [NSString stringWithFormat:@"%@?imageMogr2/auto-orient/thumbnail/60x",self];
            break;
        case HHThumbnailSize_84:
            thumnailStr = [NSString stringWithFormat:@"%@?imageMogr2/auto-orient/thumbnail/84x",self];
            break;
        case HHThumbnailSize_100:
            thumnailStr = [NSString stringWithFormat:@"%@?imageMogr2/auto-orient/thumbnail/100x",self];
            break;
        case HHThumbnailSize_110:
            thumnailStr = [NSString stringWithFormat:@"%@?imageMogr2/auto-orient/thumbnail/110x",self];
            break;
        case HHThumbnailSize_140:
            thumnailStr = [NSString stringWithFormat:@"%@?imageMogr2/auto-orient/thumbnail/140x",self];
            break;
        case HHThumbnailSize_240:
            thumnailStr = [NSString stringWithFormat:@"%@?imageMogr2/auto-orient/thumbnail/240x",self];
            break;
        case HHThumbnailSize_300:
            thumnailStr = [NSString stringWithFormat:@"%@?imageMogr2/auto-orient/thumbnail/300x",self];
            break;
        case HHThumbnailSize_330:
            thumnailStr = [NSString stringWithFormat:@"%@?imageMogr2/auto-orient/thumbnail/330x",self];
            break;
        case HHThumbnailSize_660:
            thumnailStr = [NSString stringWithFormat:@"%@?imageMogr2/auto-orient/thumbnail/660x",self];
            break;
        default:
            break;
    }
    
    return thumnailStr;
}

@end
