//
//  NSString+MJDownload.m
//  MJDownloadExample
//
//  Created by MJ Lee on 15/7/18.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "NSString+MJDownload.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MJDownload)

- (NSString *)prependCaches
{
    return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:self];
}

- (NSString *)prependDocmentCaches
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"Cashes/%@",self]];
}

- (NSString *)vocal2Path
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *fileLastName = [NSString stringWithFormat:@"vocal2%.0f.wav",interval];
    return [self stringByAppendingPathComponent:fileLastName];
}

- (NSString *)vocal1Path
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *fileLastName = [NSString stringWithFormat:@"vocal1%.0f.wav",interval];
    return [self stringByAppendingPathComponent:fileLastName];
}

- (NSString *)aacFile;
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *fileLastName = [NSString stringWithFormat:@"%.0f.aac",interval];
    return [self stringByAppendingPathComponent:fileLastName];
}

- (NSString *)remixReocrdfile
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *fileLastName = [NSString stringWithFormat:@"%.0f.wav",interval];
    return [self stringByAppendingPathComponent:fileLastName];
}

- (NSString *)speedPath:(NSString *)type
{
    NSString *fileLastName = [NSString stringWithFormat:@"%@.wav",type];
    return [self stringByAppendingPathComponent:fileLastName];
}

- (NSString *)videoCoverfile
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *fileLastName = [NSString stringWithFormat:@"%.0f.png",interval];
    return [self stringByAppendingPathComponent:fileLastName];
}

- (NSString *)recordVideoPath
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *fileLastName = [NSString stringWithFormat:@"%.0f.mp4",interval];
    NSString *videoPath = [self stringByAppendingPathComponent:fileLastName];
    return videoPath;
}

- (NSString *)filterEffectVideoPath
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *fileLastName = [NSString stringWithFormat:@"filter%.0f.mp4",interval];
    NSString *videoPath = [self stringByAppendingPathComponent:fileLastName];
    return videoPath;
}

- (NSString *)timeEffectVideoPath
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *fileLastName = [NSString stringWithFormat:@"time%.0f.mp4",interval];
    NSString *videoPath = [self stringByAppendingPathComponent:fileLastName];
    return videoPath;
}


- (NSString *)recordMusicPath
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *fileLastName = [NSString stringWithFormat:@"%.0f.mp3",interval];
    NSString *musicPath = [self stringByAppendingPathComponent:fileLastName];
    return musicPath;
}

- (NSString *)fileFolder
{
    NSString *videoFolder = [self prependDocmentCaches];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:videoFolder]) {
        [fileMgr createDirectoryAtPath:videoFolder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return videoFolder;
}

- (NSString *)currentFilePath
{
    NSString *fileStr = [NSString stringWithFormat:@"%@/%@",[self stringByDeletingLastPathComponent].lastPathComponent,self.lastPathComponent];
    return [fileStr prependDocmentCaches];
}

- (NSString *)libCashPath
{
    NSString *fileStr = [NSString stringWithFormat:@"%@/%@",[self stringByDeletingLastPathComponent].lastPathComponent,self.lastPathComponent];
    return [fileStr prependCaches];
}

- (NSString *)MD5
{
    // 得出bytes
    const char *cstring = self.UTF8String;
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cstring, (CC_LONG)strlen(cstring), bytes);
    
    // 拼接
    NSMutableString *md5String = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [md5String appendFormat:@"%02x", bytes[i]];
    }
    return md5String;
}

- (NSInteger)fileSize
{
    if ([[[NSFileManager defaultManager] attributesOfItemAtPath:self error:nil][NSFileSize] unsignedIntegerValue]) {
        return [[[NSFileManager defaultManager] attributesOfItemAtPath:self error:nil][NSFileSize] unsignedIntegerValue] ;
    } else {
        return 0;
    }
}

- (NSString *)encodedURL
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL,kCFStringEncodingUTF8));
}

- (NSString *)getFileSizeString:(NSString *)size
{
    if([size floatValue]>=1024*1024)//大于1M，则转化成M单位的字符串
    {
        return [NSString stringWithFormat:@"%1.2fM",[size doubleValue]/1024/1024];
    }
    else if([size floatValue]>=1024&&[size floatValue]<1024*1024) //不到1M,但是超过了1KB，则转化成KB单位
    {
        return [NSString stringWithFormat:@"%1.2fK",[size floatValue]/1024];
    }
    else//剩下的都是小于1K的，则转化成B单位
    {
        return [NSString stringWithFormat:@"%1.2fB",[size floatValue]];
    }
}

@end
