//
//  XUNDownloadTask.h
//  ViperArchitective
//
//  Created by xun on 17/4/28.
//  Copyright © 2017年 Xun. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPriorityLow        1000
#define kPriorityMiddle     2000
#define kPriorityHigh       3000
#define kPriorityDefault    kPriorityMiddle

typedef NS_ENUM(NSUInteger, XUNDownloadTaskStatus) {
    
    XUNDownloadTaskStatusUnknow,
    XUNDownloadTaskStatusExecuting,
    XUNDownloadTaskStatusWait,
    XUNDownloadTaskStatusPause,
    XUNDownloadTaskStatusCompleted
};

@interface XUNDownloadTask : NSObject

@property (nonatomic, readonly, strong) NSString *url;      //!< 资源路径
@property (nonatomic, readonly, strong) NSString *path;     //!< 存储路径
@property (nonatomic, readonly) NSInteger priority; //!< 优先级
@property (nonatomic, readonly) XUNDownloadTaskStatus status;
@property (nonatomic, copy) void (^DownloadProgress)(NSProgress *progress);

/// 完成回调，有些奇葩文件无法获取大小，所以需要使用该block作为回调处理
@property (nonatomic, copy) void (^CompletedBlock)();
@property (nonatomic, copy) void (^ErrorBlock)(NSError *err);

/// 是否断点续传
@property (nonatomic, assign, getter=isBreakDownload) BOOL breakDownload;

/**
 *  初始化下载任务
 *
 *  @param url 资源路径
 *  @param path 存储路径
 *  @param priority 任务优先级
 *
 *  @return 下载任务
 */
+ (instancetype)donwloadTaskWithUrl:(NSString *)url
                           savePath:(NSString *)path
                           priority:(NSInteger)priority;

+ (instancetype)donwloadTaskWithUrl:(NSString *)url
                           savePath:(NSString *)path;

@end
