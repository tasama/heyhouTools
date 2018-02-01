//
//  HHDownloadModel.h
//  FunnyTicket
//
//  Created by XiaoZefeng on 19/10/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HHDownloadModel;
@class HHVideoOperation;

typedef NS_ENUM(NSInteger, HHVideoStatus) {
    HHVideoStatusNone = 0,       // 初始状态
    HHVideoStatusRunning = 1,    // 下载中
    HHVideoStatusSuspended = 2,  // 下载暂停
    HHVideoStatusCompleted = 3,  // 下载完成
    HHVideoStatusFailed  = 4,    // 下载失败
    HHVideoStatusWaiting = 5,    // 等待下载
    //HHVideoStatusCancel = 6      // 取消下载
};
typedef void(^HHVideoStatusChanged)(HHDownloadModel *model);
typedef void(^HHVideoProgressChanged)(HHDownloadModel *model);

@interface HHDownloadModel : NSObject

@property (nonatomic, copy) NSString *videoId;
@property (nonatomic, copy) NSString *videoUrl;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSData *resumeData;
// 下载后存储到此处
@property (nonatomic, copy) NSString *localPath;
@property (nonatomic, copy) NSString *progressText;

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) HHVideoStatus status;
@property (nonatomic, strong) HHVideoOperation *operation;

@property (nonatomic, copy) HHVideoStatusChanged onStatusChanged;
@property (nonatomic, copy) HHVideoProgressChanged onProgressChanged;

@property (nonatomic, readonly, copy) NSString *statusText;

@end
