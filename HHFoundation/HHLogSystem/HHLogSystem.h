//
//  HHLogSystem.h
//  FunnyTicket
//
//  Created by 袁良 on 2017/4/15.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

#define HHLogVerbose DDLogVerbose
#define HHLogDebug DDLogDebug
#define HHLogInfo DDLogInfo
#define HHLogWarn DDLogWarn
#define HHLogError DDLogError

#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelInfo;
#endif

@interface HHLogSystem : NSObject

+ (instancetype)sharedHHLogSystem;

@property (nonatomic, copy) NSString *logPath;

- (void)setup;

@end
