//
//  XUNDownloadManager.h
//  ViperArchitective
//
//  Created by xun on 17/4/28.
//  Copyright © 2017年 Xun. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kMaximumDownloadTask    5

@class XUNDownloadTask;

@interface XUNDownloadManager : NSObject

/// 等待下载队列
@property (nonatomic, readonly) NSArray *waitingQueue;

/// 正在下载队列
@property (nonatomic, readonly) NSArray *downloadingQueue;

/// 暂停下载队列
@property (nonatomic, readonly) NSArray *pauseQueue;

/// 所有下载队列
@property (nonatomic, readonly) NSArray *allQueue;

/// 最大同时下载数
@property (nonatomic, readonly) NSUInteger maximumDownloadTask;

+ (instancetype)shareManager;

/// 添加下载任务，如果满足条件立即执行下载
- (void)addDownloadTask:(XUNDownloadTask *)task;

/// 移除下载任务并清除缓存文件
- (void)removeDownloadTask:(XUNDownloadTask *)task;

/// 暂停下载任务，需用户手动唤起执行
- (void)pauseDownloadTask:(XUNDownloadTask *)task;

/// 执行下载任务，若当前下载任务达到最大量，且优先级均小于当前下载任务优先级，执行失败；如果下载任务没有加在当前管理器中，唤醒失败
- (BOOL)resumeDownloadTask:(XUNDownloadTask *)task;

/// 根据URL获取下载任务，如果当前任务管理器不存在该任务
- (XUNDownloadTask *)getDownloadTaskWithUrl:(NSString *)url;

@end
