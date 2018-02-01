//
//  XUNDownloadManager.m
//  ViperArchitective
//
//  Created by xun on 17/4/28.
//  Copyright © 2017年 Xun. All rights reserved.
//

#import "XUNDownloadManager.h"
#import "XUNDownloadTask.h"
#import "NSFileManager+HHFTVideoCache.h"
#import <objc/runtime.h>
#import <AFNetworking.h>

#define kAssociationDownloadTaskKey "XUN_ASSOCIATION_DOWNLOAD_TASK_KEY"
#define kDownloadTaskCompletedNoti  @"XUN_DOWNLOAD_TASK_COMPLETED_NOTI"

@interface XUNDownloadTask (XUNDownloadManager)

@property (nonatomic, readonly) NSURLSessionDownloadTask *task;

@end

@implementation XUNDownloadTask (XUNDownloadManager)

- (NSURLSessionDownloadTask *)task {
    
    NSURLSessionDownloadTask *task = objc_getAssociatedObject(self, kAssociationDownloadTaskKey);
    
    if (!task) {
        
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
        
        if (self.isBreakDownload) {
            
            NSFileManager *fm = [NSFileManager defaultManager];
            
            NSDictionary *dict = [fm attributesOfItemAtPath:self.path error:nil];
            
            [request setValue:[NSString stringWithFormat:@"bytes=%llu-", [dict[NSFileSize] longLongValue]] forHTTPHeaderField:@"Range"];
        }
        
        task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            
            !self.DownloadProgress?:self.DownloadProgress(downloadProgress);
            
        } destination:^(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            
            return [NSURL fileURLWithPath:self.path];
            
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            
            if (error) {
                
                !self.ErrorBlock?:self.ErrorBlock(error);
                return ;
            }
            else {
                
                !self.CompletedBlock?:self.CompletedBlock();
                [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadTaskCompletedNoti object:self];
            }
            
        }];

        objc_setAssociatedObject(self, kAssociationDownloadTaskKey, task, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return task;
}

#pragma mark - Override

- (XUNDownloadTaskStatus)status {
    
    if (self.task.state == NSURLSessionTaskStateRunning) {
        
        return XUNDownloadTaskStatusExecuting;
    }
    else if (self.task.state == NSURLSessionTaskStateSuspended) {
        
        return XUNDownloadTaskStatusPause;
    }
    else if (self.task.state == NSURLSessionTaskStateCompleted) {
        
        return XUNDownloadTaskStatusCompleted;
    }
    else if ([[XUNDownloadManager shareManager].waitingQueue containsObject:self]){
        
        return XUNDownloadTaskStatusWait;
    }
    else {
        
        return XUNDownloadTaskStatusUnknow;
    }
}

@end

@implementation XUNDownloadManager
{
    /// 等待下载队列
    NSMutableArray <XUNDownloadTask *> *waitingQueue;
    
    /// 正在下载队列
    NSMutableArray <XUNDownloadTask *> *downloadingQueue;
    
    /// 暂停下载队列
    NSMutableArray <XUNDownloadTask *> *pauseQueue;
    
    /// 所有下载队列
    NSMutableArray <XUNDownloadTask *> *allQueue;
}

+ (instancetype)shareManager {
    
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static XUNDownloadManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [super allocWithZone:zone];
        
        manager->downloadingQueue = [NSMutableArray array];
        manager->allQueue = [NSMutableArray array];
        manager->pauseQueue = [NSMutableArray array];
        manager->waitingQueue = [NSMutableArray array];
        
        [[NSNotificationCenter defaultCenter] addObserver:manager selector:@selector(downloadTaskCompleted:) name:kDownloadTaskCompletedNoti object:nil];
    });
    
    return manager;
}

#pragma mark - Interface Method

- (void)addDownloadTask:(XUNDownloadTask *)task {
    
    if (!task) return;
    
    if (![self queue:allQueue containTask:task]) {
        
        [allQueue addObject:task];
    }

    [self resumeDownloadTask:task];
}

- (void)removeDownloadTask:(XUNDownloadTask *)task {
    
    if (!task)  return;
    
    [task.task cancel];
    
    if ([allQueue containsObject:task]) {
        
        [allQueue removeObject:task];
    }
    
    if ([downloadingQueue containsObject:task]) {
        
        [task.task cancel];
        
        [downloadingQueue removeObject:task];
        
        [self resumeDownloadTask:waitingQueue.firstObject];
    }
    else if ([waitingQueue containsObject:task]) {
        
        [waitingQueue removeObject:task];
    }
    else if ([pauseQueue containsObject:task]) {
        
        [pauseQueue removeObject:task];
    }
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    [fm removeItemAtPath:task.path error:nil];
}

- (void)pauseDownloadTask:(XUNDownloadTask *)task {
    
    if (!task) return;
    
    if (![self queue:allQueue containTask:task]) {
        
        return;
    }
    
    if ([downloadingQueue containsObject:task]) {
        
        [task.task suspend];
        
        [downloadingQueue removeObject:task];
        [pauseQueue addObject:task];
    }
    else if ([waitingQueue containsObject:task]) {
        
        [waitingQueue removeObject:task];
        [pauseQueue addObject:task];
    }
}

- (BOOL)resumeDownloadTask:(XUNDownloadTask *)task {
    
    if (!task) return NO;
    
    //  不在此管理器中
    if (![self queue:allQueue containTask:task]) {
        
        return NO;
    }
    
    //  已经在下载
    if ([self queue:downloadingQueue containTask:task]) {
        
        return YES;
    }
    
    if (downloadingQueue.count < kMaximumDownloadTask) {

        [task.task resume];
        
        if ([waitingQueue containsObject:task]) {
            
            [waitingQueue removeObject:task];
        }
        else if ([pauseQueue containsObject:task]) {
            
            [pauseQueue removeObject:task];
        }
        
        //  如果下载队列没有下载任务 || 优先级小于最后一个，则添加在末尾
        if (!downloadingQueue.count || downloadingQueue.lastObject.priority >= task.priority) {
            
            [downloadingQueue addObject:task];
    
            return YES;
        }
        
        // 按照优先级排序
        for (int i = 0; i < downloadingQueue.count; i++) {
            
            if (downloadingQueue[i].priority < task.priority) {
                
                [downloadingQueue insertObject:task atIndex:i];
                break;
            }
        }
        
        return YES;
    }
    
    //  下载任务唤醒结果
    BOOL resumeResult;
    
    for (int i = 0; i < self.maximumDownloadTask; i++) {
        
        if (downloadingQueue[i].priority < task.priority) {
            
            [task.task resume];
            
            [downloadingQueue insertObject:task atIndex:i];
            [downloadingQueue removeObject:downloadingQueue.lastObject];
            
            [waitingQueue addObject:downloadingQueue.lastObject];
            
            resumeResult = YES;
            
            break;
        }
    }
    
    //  唤醒失败，加入等待队列中
    if (!resumeResult) {
        
        if (!waitingQueue.count) {
            
            [waitingQueue addObject:task];
        }
        else {
            
            for (int i = 0; i < waitingQueue.count; i++) {
                
                if (waitingQueue[i].priority < task) {
                    
                    [waitingQueue insertObject:task atIndex:i];
                    break;
                }
            }
        }
    }
    
    return resumeResult;
}

- (XUNDownloadTask *)getDownloadTaskWithUrl:(NSString *)url {
    
    if (!url) return nil;
    
    for (XUNDownloadTask *downloadTask in allQueue) {
        
        if ([downloadTask.url isEqualToString:url]) {
            
            return downloadTask;
        }
    }
    
    return nil;
}

#pragma mark - Private Method

- (BOOL)queue:(NSArray *)queue containTask:(XUNDownloadTask *)task {
    
    if ([queue containsObject:task]) {
        
        return YES;
    }
    
    for (XUNDownloadTask *tmpTask in queue) {
        
        if ([tmpTask.url isEqualToString:task.url]) {
            
            !task.ErrorBlock?:task.ErrorBlock([NSError errorWithDomain:@"重复下载" code:1024 userInfo:nil]);
            
            return YES;
        }
    }
    
    return NO;
}

- (void)downloadTaskCompleted:(NSNotification *)noti {
    
    //  移出管理器和下载队列
    [allQueue removeObject:noti.object];
    [downloadingQueue removeObject:noti.object];
    
    if (waitingQueue.count) {
        
        //  查找优先级最高的等待下载任务
        XUNDownloadTask *highPriortyTask = waitingQueue.firstObject;
        
        for (int i = 0; i < waitingQueue.count; i++) {
            
            if (waitingQueue[i].priority > highPriortyTask.priority) {
                
                highPriortyTask = waitingQueue[i];
            }
        }
        
        [highPriortyTask.task resume];
        [downloadingQueue addObject:highPriortyTask];
        [waitingQueue removeObject:highPriortyTask];
    }
}

#pragma mark - Getter 

- (NSUInteger)maximumDownloadTask {
    
    return kMaximumDownloadTask;
}

- (NSArray *)allQueue {
    
    return allQueue;
}

- (NSArray *)waitingQueue {
    
    return waitingQueue;
}

- (NSArray *)pauseQueue {
    
    return pauseQueue;
}

- (NSArray *)downloadingQueue {
    
    return downloadingQueue;
}

@end
