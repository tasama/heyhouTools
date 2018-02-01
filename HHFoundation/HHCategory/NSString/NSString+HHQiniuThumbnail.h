//
//  NSString+HHQiniuThumbnail.h
//  FunnyTicket
//
//  Created by heyhou on 17/3/17.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HHThumbnailSize) {
    HHThumbnailSize_60,
    HHThumbnailSize_84,
    HHThumbnailSize_100,
    HHThumbnailSize_110,
    HHThumbnailSize_140,
    HHThumbnailSize_240,
    HHThumbnailSize_300,
    HHThumbnailSize_330,
    HHThumbnailSize_660
};


@interface NSString (HHQiniuThumbnail)

- (NSString *)thumbnailUrlStr:(HHThumbnailSize)size;

@end
