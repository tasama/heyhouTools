//
//  HHVideoOperation.h
//  FunnyTicket
//
//  Created by XiaoZefeng on 19/10/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HHDownloadModel;

@interface NSURLSessionTask (VideoModel)

// 为了更方便去获取，而不需要遍历，采用扩展的方式，可直接提取，提高效率
@property (nonatomic, weak) HHDownloadModel *hh_videoModel;

@end

@interface HHVideoOperation : NSOperation

- (instancetype)initWithModel:(HHDownloadModel *)model session:(NSURLSession *)session;

@property (nonatomic, weak) HHDownloadModel *model;
@property (nonatomic, strong, readonly) NSURLSessionDownloadTask *downloadTask;

- (void)suspend;
- (void)resume;
- (void)downloadFinished;

@end
