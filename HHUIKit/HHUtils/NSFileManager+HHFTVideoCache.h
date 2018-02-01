//
//  NSFileManager+HHFTVideoCache.h
//  FunnyTicket
//
//  Created by Xun on 17/4/28.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface NSFileManager (HHFTVideoCache)

///  初始化潮拍视频缓存文件夹
+ (BOOL)initFTVideoDirectory;

///潮拍视频存储路径
+ (NSString *)FTVideoDirectory;

/// 根据URL获取存储路径
+ (NSString *)FTVideoPathWithUrl:(NSString *)url;

+ (BOOL)clearFTVideoCache;

/**
 根据url获取本地缓存资源文件

 @param url url字符串
 @return 资源文件
 */
+ (AVURLAsset *)FTVideoURLAssetWithUrl:(NSString *)url;

/**
 计算潮拍视频缓存大小，可能较卡，请开启异步线程

 @param size 已知大小
 @return 缓存大小
 */
+ (size_t)FTVideoCacheSize:(void (^)(size_t))size;


@end

CA_EXTERN const NSString *MJDownloadIdentifier;
