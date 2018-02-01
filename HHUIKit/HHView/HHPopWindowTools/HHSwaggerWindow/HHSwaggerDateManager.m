//
//  HHSwaggerDateManager.m
//  FunnyTicket
//
//  Created by tasama on 17/8/8.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHSwaggerDateManager.h"
#import <HHFoundation/HHConst.h>

@implementation HHSwaggerDateManager

NSString *const LASTBootDate = @"lastBootDate";
NSString *const LaunchBootDate = @"launchBootDate";

+ (BOOL)swaggerAlertShouldShow {
    
    NSString *nowDate = [[NSUserDefaults standardUserDefaults] objectForKey:LASTBootDate];
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"adPictureUrlChanged"] boolValue]) {
        
        NSString *lastDate =   [[NSUserDefaults standardUserDefaults] objectForKey:LaunchBootDate];
        
        if ([lastDate length]) {
            
            NSArray *nowDateArrary = [nowDate componentsSeparatedByString:@"-"];
            NSArray *lastDateArrary = [lastDate componentsSeparatedByString:@"-"];
            
            BOOL flag = NO;
            for (int i = 0; i < nowDateArrary.count; i ++) {
                
                NSString *nowSinglePart = nowDateArrary[i];
                NSString *lastSinglePart = lastDateArrary[i];
                if (![nowSinglePart isEqualToString:lastSinglePart]) {
                    
                    flag = YES;
                    break;
                }
            }
            if (flag == YES) {
                [[NSUserDefaults standardUserDefaults] setObject:nowDate forKey:LaunchBootDate];
                [[NSUserDefaults standardUserDefaults] synchronize];
                return YES;
            } else {
                [[NSUserDefaults standardUserDefaults] setObject:lastDate forKey:LaunchBootDate];
                [[NSUserDefaults standardUserDefaults] synchronize];
                return NO;
            }
        }
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:@"adPictureUrlChanged"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    [[NSUserDefaults standardUserDefaults] setObject:nowDate forKey:LaunchBootDate];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}

+ (NSString *)currentDateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]/*[NSDate alloc] internetDate]*/];
    return currentDateStr;
}

@end
