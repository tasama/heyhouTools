//
//  NSString+MJDownload.h
//  MJDownloadExample
//
//  Created by MJ Lee on 15/7/18.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MJDownload)
/**
 *  在前面拼接caches文件夹
 */
- (NSString *)prependCaches;

/**
 *  生成MD5摘要
 */
- (NSString *)MD5;

/**
 *  文件大小
 */
- (NSInteger)fileSize;

/**
 *  生成编码后的URL
 */
- (NSString *)encodedURL;

/** 将文件大小转化成M单位或者B单位 */
- (NSString *)getFileSizeString:(NSString *)size;

- (NSString *)remixReocrdfile;
/** 区分录制的时候同一时间初始化2条音轨的路径 */
- (NSString *)vocal2Path;
/** 区分录制的时候同一时间初始化1条音轨的路径 */
- (NSString *)vocal1Path;

/** 录音上传格式 */
- (NSString *)aacFile;


- (NSString *)videoCoverfile;

- (NSString *)currentFilePath;

/**
lib->cash路径
 */
- (NSString *)libCashPath;

/**
 doc->cash路径
 */
- (NSString *)prependDocmentCaches;

- (NSString *)recordVideoPath;

- (NSString *)filterEffectVideoPath;

- (NSString *)timeEffectVideoPath;

- (NSString *)recordMusicPath;

- (NSString *)fileFolder;

- (NSString *)speedPath:(NSString *)type;

@end
