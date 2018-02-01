//
//  XUNDownloadTask.m
//  ViperArchitective
//
//  Created by xun on 17/4/28.
//  Copyright © 2017年 Xun. All rights reserved.
//

#import "XUNDownloadTask.h"
#import "XUNDownloadManager.h"
#import <HHFoundation/HHLogSystem.h>

@implementation XUNDownloadTask
{
    NSString *url;      //!< 资源路径
    NSString *path;     //!< 存储路径
    NSInteger priority; //!< 优先级
}

+ (instancetype)donwloadTaskWithUrl:(NSString *)url
                           savePath:(NSString *)path
                           priority:(NSInteger)priority {
    
    NSAssert(url.length, @"URL不能为空");
    NSAssert(path.length, @"存储路径不能为空");
    
    if (!url.length || !path.length) {
        
        return nil;
    }
    
    XUNDownloadTask *task = [[self alloc] init];
    
    task->url = url;
    task->path = path;
    task->priority = priority;
    
    return task;
}

+ (instancetype)donwloadTaskWithUrl:(NSString *)url savePath:(NSString *)path {
    
    return [self donwloadTaskWithUrl:url savePath:path priority:kPriorityDefault];
}

- (NSString *)url {
    
    if ([url isKindOfClass:[NSURL class]]) {
        NSURL *URL = (NSURL *)url;
        return URL.absoluteString;
    }
    
    return url;
}

- (NSString *)path {
    
    return path;
}

- (NSInteger)priority {
    
    return priority;
}

//- (XUNDownloadTaskStatus)status {
//    
//    XUNDownloadManager *manager = [XUNDownloadManager shareManager];
//    
//    if ([manager.downloadingQueue containsObject:self]) {
//        
//        return XUNDownloadTaskStatusExecuting;
//    }
//    else if ([manager.waitingQueue containsObject:self]) {
//        
//        return XUNDownloadTaskStatusWait;
//    }
//    else if ([manager.pauseQueue containsObject:self]) {
//        
//        return XUNDownloadTaskStatusPause;
//    }
//    return XUNDownloadTaskStatusUnknow;
//}

- (void)dealloc {
    
    HHLogDebug(@"task 被释放了");
}

@end
