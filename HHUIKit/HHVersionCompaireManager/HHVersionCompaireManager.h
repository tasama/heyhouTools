//
//  HHVersionCompaireManager.h
//  FunnyTicket
//
//  Created by tasama on 17/5/31.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHVersionCompaireManager : NSObject

+ (BOOL)compairVersion:(NSString *)version;

+ (NSString *)getAppVersion;

+ (NSString *)getAppVersionForTag;

@end

//版本标签标示
extern NSString *const VersionTag;
