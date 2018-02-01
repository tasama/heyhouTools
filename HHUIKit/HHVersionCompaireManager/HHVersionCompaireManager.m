//
//  HHVersionCompaireManager.m
//  FunnyTicket
//
//  Created by tasama on 17/5/31.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHVersionCompaireManager.h"

NSString *const VersionTag = @"heyhou_versionTag-";

@implementation HHVersionCompaireManager

+ (BOOL)compairVersion:(NSString *)version {
    
    NSInteger result = [self compairVersionWithVersion:[self getAppVersion] andWithLatestVersion:version];
    
    if (result < 0) {
        
        return YES;
    } else {
        
        return NO;
    }
}

+ (NSString *)getAppVersion {
    
    NSDictionary *infoPlistDic = [[NSBundle mainBundle] infoDictionary];
    
    return [infoPlistDic objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)getAppVersionForTag {
    
    NSDictionary *infoPlistDic = [[NSBundle mainBundle] infoDictionary];
    
    return [VersionTag stringByAppendingString:[infoPlistDic objectForKey:@"CFBundleShortVersionString"]];
}

/**
 比较版本号
 
 @param localVersion  本地版本
 @param latestVersion 远端最新版本
 
 @return -1，远端版本较大 0，一样大 1，本地版本较大
 */
+ (NSInteger)compairVersionWithVersion:(NSString *)localVersion andWithLatestVersion:(NSString *)latestVersion {
    
    if (!localVersion && !latestVersion) {
        
        return NSOrderedSame;
    }
    
    if (!localVersion && latestVersion) {
        
        return NSOrderedAscending;
    }
    
    if (localVersion && !latestVersion) {
        return NSOrderedDescending;
    }

    return [localVersion compare:latestVersion options:NSNumericSearch];
}

@end
