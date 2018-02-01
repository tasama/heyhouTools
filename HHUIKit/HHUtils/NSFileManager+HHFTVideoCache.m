//
//  NSFileManager+HHFTVideoCache.m
//  FunnyTicket
//
//  Created by Xun on 17/4/28.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "NSFileManager+HHFTVideoCache.h"
#import "NSString+MD5HexDigest.h"

#define kFTVideoDirectoryPathComponent @"fashionTakingVideo"

@implementation NSFileManager (HHFTVideoCache)

+ (BOOL)initFTVideoDirectory {
    
    return [[self defaultManager] createDirectoryAtPath:[self FTVideoDirectory] withIntermediateDirectories:NO attributes:nil error:nil];
}

+ (NSString *)FTVideoDirectory {
    
    NSString *rootDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    
    return [rootDir stringByAppendingPathComponent:kFTVideoDirectoryPathComponent];
}

+ (NSString *)FTVideoPathWithUrl:(NSString *)url {
    
    return [[self FTVideoDirectory] stringByAppendingPathComponent:[[[url stringByDeletingPathExtension] md5HexDigest] stringByAppendingPathExtension:url.pathExtension]];
}

+ (AVURLAsset *)FTVideoURLAssetWithUrl:(NSString *)url {
    
    NSString *ecryptStr = [[[url stringByDeletingPathExtension] md5HexDigest] stringByAppendingPathExtension:url.pathExtension];
    
    NSString *filePath = [[NSFileManager FTVideoDirectory] stringByAppendingPathComponent:ecryptStr];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        return [AVURLAsset assetWithURL:[NSURL fileURLWithPath:filePath]];
    }
    return nil;
}

+ (BOOL)clearFTVideoCache {
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm removeItemAtPath:[self FTVideoDirectory] error:nil]) {
        
        /// 删完之后，重新创建
        [self initFTVideoDirectory];
        
        return YES;
    }
    
    return NO;
}

+ (size_t)FTVideoCacheSize:(void (^)(size_t))size {
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSDirectoryEnumerator *enumerator = [fm enumeratorAtPath:[NSFileManager FTVideoDirectory]];

    size_t totalSize = 0;
    
    NSString *path = nil;
    
    NSString *rootDir = [self FTVideoDirectory];
    
    while (path = [enumerator nextObject]) {
        
        totalSize += [[fm attributesOfItemAtPath:[rootDir stringByAppendingPathComponent:path] error:nil][NSFileSize] longLongValue];
        
        !size? :size(totalSize);
    }
    
    return totalSize;
}


@end

const NSString *MJDownloadIdentifier = @"MJDownloadManagerIdentifier";
