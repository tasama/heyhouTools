//
//  HHGuideTool.m
//  FunnyTicket
//
//  Created by Jude on 17/9/15.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHGuideTool.h"
#import "HHConst.h"

@implementation HHGuideTool

+(BOOL)recordStuidoFirstRecord
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL first = [defaults boolForKey:HHRSFirstRecord];
    if (!first) {
        [defaults setBool:YES forKey:HHRSFirstRecord];
        [defaults synchronize];
    }
    return first;
}

+(BOOL)recordStuidoFirstEdit
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL first = [defaults boolForKey:HHRSFirstEdit];
    if (!first) {
        [defaults setBool:YES forKey:HHRSFirstEdit];
        [defaults synchronize];
    
    }
    return first;
}

+(BOOL)recordStuidoFirstMute
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL first = [defaults boolForKey:HHRSFirstMute];
    if (!first) {
        [defaults setBool:YES forKey:HHRSFirstMute];
        [defaults synchronize];
    }
    return first;
}

+(BOOL)recordStuidoFirstSolo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL first = [defaults boolForKey:HHRSFirstSolo];
    if (!first) {
        [defaults setBool:YES forKey:HHRSFirstSolo];
        [defaults synchronize];
    }
    return first;
}

+ (BOOL)firstShowRecordArrow {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL first = [defaults boolForKey:HHRSFirstShowArrow];
    if (!first) {
        [defaults setBool:YES forKey:HHRSFirstShowArrow];
        [defaults synchronize];
    }
    return first;
}

@end
