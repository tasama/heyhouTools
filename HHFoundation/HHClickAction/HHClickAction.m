 //
//  HHClickAction.m
//  FunnyTicket
//
//  Created by tasama on 17/5/3.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHClickAction.h"
#import "NSDate+HHExtension.h"
#import "HHNetTool.h"
#import "HHLogSystem.h"
#import "HHMarco.h"
#import "NSObject+JSON.h"

@interface HHClickAction ()

@end

@implementation HHClickAction

static NSInteger HHEventMaxCount = 30;
static dispatch_queue_t HHClickActionQueue;


static HHClickAction *_instance;

+ (HHClickAction *)sharedHHClickAction
{
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

+ (instancetype)shareClick {
    
    return [HHClickAction sharedHHClickAction];
}

+ (void)setEventMaxCount:(NSInteger)maxCount {
    
    HHEventMaxCount = maxCount;
}

+ (void)event:(NSString *)event andObject:(NSDictionary * _Nullable)object {
    
    BOOL isCanReport = [[[NSUserDefaults standardUserDefaults] valueForKey:@"isCanReport"] integerValue];
    
    if (isCanReport) {
        
        return;
    }
    
    NSMutableDictionary *tempDic = @{}.mutableCopy;
    if (!kStringIsEmpty(event)) {
        [tempDic addEntriesFromDictionary:@{HHEVENT_ID: event}];
    }
    
    if (!kObjectIsEmpty(object)) {
        NSDictionary *dict = @{HHEVENT_OBJECT : object};
        [tempDic addEntriesFromDictionary:dict];
    }
    
    long time = [NSDate dateLongAboutCurrentTime];
    [tempDic addEntriesFromDictionary:@{HHEVENT_TIME: @(time)}];
    
    
    if (!HHClickActionQueue) {
        HHClickActionQueue = dispatch_queue_create("eventListQueue", DISPATCH_QUEUE_SERIAL);
    }
    
    dispatch_async(HHClickActionQueue, ^{
        NSString *configFile = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"event.plist"];
        NSMutableArray *files = [[NSMutableArray alloc] initWithContentsOfFile:configFile];
        
        if (!files) {
            files = @[].mutableCopy;
        }
        [files addObject:tempDic.copy];
        
        [files writeToFile:configFile atomically:YES];
        
        if (files.count == HHEventMaxCount) {
            NSMutableArray *temp = @[].mutableCopy;
            [temp writeToFile:configFile atomically:YES];
            if (!(files.count > 0)) {
                return;
            }
            NSString *events = [files.copy hh_JSONString];
            if (HHClickAction.shareClick.uploadEvent) {
                HHClickAction.shareClick.uploadEvent(events);
            }
        }
        
        if (files.count > HHEventMaxCount) {

            [files removeObjectsInRange:NSMakeRange(0, HHEventMaxCount)];
            [files writeToFile:configFile atomically:YES];
        }
    });
}

+ (void)bootUp {
    
    //todo
    [self appBootUpEventSuccess:^(NSInteger ret, id  _Nullable obj) {
        if (!ret) {
            HHLogDebug(@"启动上报成功");
        } else {

            HHLogDebug(@"启动上报失败");
        }
    } Failed:^(NSError * _Nonnull error) {
        HHLogDebug(@"启动上报失败");
    }];

    [self appEventSwitchSuccess:^(NSInteger ret, id  _Nullable obj) {

        if (!ret) {

            if ([obj[@"isCanReport"] integerValue]) {

                [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:@"isCanReport"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            } else {

                [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"isCanReport"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
    } Failed:^(NSError * _Nonnull error) {

        HHLogDebug(@"获取上报权限失败");
    }];
}

+ (void)appBootUpEventSuccess:(SuccessBlock)success Failed:(FailedBlock)failed {
    
    NSMutableDictionary *parameters = @{}.mutableCopy;
  
    [HHNetTool GET:@"app/statistic/boot_up" parameters:parameters success:^(id  _Nullable responseObject) {
        
        if (success) {
            NSDictionary *result = responseObject;
            NSInteger ret = [result[@"ret"] integerValue];
            
            if (!ret) {
                success(ret, nil);
            } else {
                success(ret, nil);
            }
        }
    } failure:^(NSError * _Nonnull error) {
        
        if (failed) {
            
            failed(error);
        }
    }];
}

+ (void)appEventSwitchSuccess:(SuccessBlock)success Failed:(FailedBlock)failed {
    
    [HHNetTool GET:@"/app/statistic/app_event_switch" parameters:nil success:^(id  _Nullable responseObject) {
        if (success) {
            NSDictionary *result = responseObject;
            NSInteger ret = [result[@"ret"] integerValue];
            
            if (!ret) {
                id data = result[@"data"];
                success(ret, data);
            } else {
                success(ret, nil);
            }
        }
    } failure:^(NSError * _Nonnull error) {
        if (failed) {
            failed(error);
        }
    }];
}
@end
