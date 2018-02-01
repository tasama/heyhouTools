//
//  SUFileHandle.m
//  SULoader
//
//  Created by 万众科技 on 16/6/28.
//  Copyright © 2016年 万众科技. All rights reserved.
//

#import "SUFileHandle.h"
#import "NSFileManager+HHFTVideoCache.h"

@interface SUFileHandle ()

@property (nonatomic, strong) NSFileHandle * writeFileHandle;
@property (nonatomic, strong) NSFileHandle * readFileHandle;

@end

@implementation SUFileHandle

+ (BOOL)createTempFile {
    NSFileManager * manager = [NSFileManager defaultManager];
    NSString * path = [NSString tempFilePath];
    if ([manager fileExistsAtPath:path]) {
        [manager removeItemAtPath:path error:nil];
    }
    return [manager createFileAtPath:path contents:nil attributes:nil];
}

+ (void)writeTempFileData:(NSData *)data {
    NSFileHandle * handle = [NSFileHandle fileHandleForWritingAtPath:[NSString tempFilePath]];
    [handle seekToEndOfFile];
    [handle writeData:data];
}

+ (NSData *)readTempFileDataWithOffset:(NSUInteger)offset length:(NSUInteger)length {
    NSFileHandle * handle = [NSFileHandle fileHandleForReadingAtPath:[NSString tempFilePath]];
    [handle seekToFileOffset:offset];
    return [handle readDataOfLength:length];
}

+ (void)cacheTempFileWithFileName:(NSString *)url {
//    NSFileManager * manager = [NSFileManager defaultManager];
//    NSString * cacheFolderPath = [NSString cacheFolderPath];
//    if (![manager fileExistsAtPath:cacheFolderPath]) {
//        [manager createDirectoryAtPath:cacheFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    NSString * cacheFilePath = [NSString stringWithFormat:@"%@/%@", cacheFolderPath, name];
    NSString *newUrl = [url stringByReplacingOccurrencesOfString:@"streaming://" withString:@"http://"];
    NSString *cacheFilePath = [NSFileManager FTVideoPathWithUrl:newUrl];
    BOOL success = [[NSFileManager defaultManager] copyItemAtPath:[NSString tempFilePath] toPath:cacheFilePath error:nil];
    NSLog(@"cache file : %@", success ? @"success" : @"fail");
}

+ (NSString *)cacheFileExistsWithURL:(NSURL *)url {
    NSString *newUrl = [url.absoluteString stringByReplacingOccurrencesOfString:@"streaming://" withString:@"http://"];
    NSString * cacheFilePath = [NSFileManager FTVideoPathWithUrl:newUrl];
    if ([[NSFileManager defaultManager] fileExistsAtPath:cacheFilePath]) {
        return cacheFilePath;
    }
    return nil;
}

+ (BOOL)clearCache {
    NSFileManager * manager = [NSFileManager defaultManager];
    return [manager removeItemAtPath:[NSString cacheFolderPath] error:nil];
}

+ (size_t)cacheSize:(void (^)(size_t))size {
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSString * cacheFolderPath = [NSString cacheFolderPath];
    NSDirectoryEnumerator *enumerator = [fm enumeratorAtPath:cacheFolderPath];
    
    size_t totalSize = 0;
    
    NSString *path = nil;
    
    NSString *rootDir = cacheFolderPath;
    
    while (path = [enumerator nextObject]) {
        
        totalSize += [[fm attributesOfItemAtPath:[rootDir stringByAppendingPathComponent:path] error:nil][NSFileSize] longLongValue];
        
        !size? :size(totalSize);
    }
    
    return totalSize;
}

@end
