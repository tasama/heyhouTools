//
//  HHLogSystem.m
//  FunnyTicket
//
//  Created by 袁良 on 2017/4/15.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import "HHLogSystem.h"

@implementation HHLogSystem

static HHLogSystem *_instance;

+ (instancetype)sharedHHLogSystem {
    
    if (_instance == nil) {
        _instance = [[self alloc] init];
    }
    return _instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}


- (void)setup
{
#ifdef DEBUG
    // 控制台输出
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
#else
    // 日志写到文件中
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
    fileLogger.rollingFrequency = 0;
    fileLogger.logFileManager.logFilesDiskQuota = 100 * 1024; // 存储空间100K
    fileLogger.logFileManager.maximumNumberOfLogFiles = 1;
    [DDLog addLogger:fileLogger withLevel:DDLogLevelInfo];
    
    self.logPath = fileLogger.currentLogFileInfo.filePath;
#endif
    
    HHLogInfo(@"HHLogSystem setup success!");
}

@end
