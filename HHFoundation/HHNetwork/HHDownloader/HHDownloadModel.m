//
//  HHDownloadModel.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 19/10/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "HHDownloadModel.h"
#import <HHLogSystem.h>

@implementation HHDownloadModel

- (NSString *)localPath
{
    NSString *pathName = [NSString stringWithFormat:@"/Documents/HHVideos/%@.mp4",self.videoId];
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:pathName];
    return filePath;
}

- (void)setProgress:(CGFloat)progress
{
    if (_progress != progress)
    {
        _progress = progress;

        if (self.onProgressChanged)
        {
            self.onProgressChanged(self);
        }
        else
        {
            HHLogDebug(@"progress changed block is empty");
        }
    }
}

- (void)setStatus:(HHVideoStatus )status
{
    if (_status != status)
    {
        _status = status;
        if (self.onStatusChanged)
        {
            self.onStatusChanged(self);
        }
    }
}

- (NSString *)statusText
{
    switch (self.status)
    {
        case HHVideoStatusNone:
        {
            return @"";
            break;
        }
        case HHVideoStatusRunning:
        {
            return @"下载中";
            break;
        }
        case HHVideoStatusSuspended: {
            return @"暂停下载";
            
            break;
        }
        case HHVideoStatusCompleted:
        {
            return @"下载完成";
            break;
        }
        case HHVideoStatusFailed:
        {
            return @"下载失败";
            break;
        }
        case HHVideoStatusWaiting:
        {
            return @"等待下载";
            break;
        }
    }
}


@end
