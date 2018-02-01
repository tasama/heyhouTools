//
//  HHExceptionManager.m
//  CatchException
//
//  Created by tasama on 17/5/31.
//  Copyright © 2017年 tasama. All rights reserved.
//

#import "HHExceptionManager.h"


@implementation HHExceptionManager

void uncaughtExceptionHandler(NSException *exception) {
    
    NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsPathArr lastObject];
    // 拼接要写入文件的路径
    NSString *file = [documentsPath stringByAppendingPathComponent:@"exception.plist"];
    
    NSMutableDictionary *exceptionDic = [NSMutableDictionary dictionaryWithContentsOfFile:file];
    if (!exceptionDic) {
        
        exceptionDic = @{}.mutableCopy;
    }
    NSInteger exceptionTime = [exceptionDic[@"exceptionTime"] integerValue];
    exceptionTime += 1;
    [exceptionDic setValue:@(exceptionTime) forKey:@"exceptionTime"];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    if (![mgr fileExistsAtPath:file]) {
        [mgr createFileAtPath:file contents:nil attributes:nil];
    }
    
    [exceptionDic writeToFile:file atomically:YES];
}

+ (NSString *)getFile {
    
    NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsPathArr lastObject];
    // 拼接要写入文件的路径
    return [documentsPath stringByAppendingPathComponent:@"exception.plist"];
}

+ (instancetype)shared {
    static HHExceptionManager *exceptionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        exceptionManager = [[HHExceptionManager alloc] init];
    });
    
    return exceptionManager;
}

+ (void)beginCatch {
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    [[self shared] callBlock:^{
        [self cleanExceptionRecord];
    } afterDelay:8.0f];
}

- (void)callBlock:(void(^)(void))block afterDelay:(NSTimeInterval)delayTime {
    
    [self performSelector:@selector(callTheBlcok:) withObject:block afterDelay:delayTime];
}

- (void)callTheBlcok:(void(^)(void))block {
    
    block();
}

+ (void)cleanExceptionRecord {
    
    NSString *file = [self getFile];
    NSMutableDictionary *exceptions = [NSMutableDictionary dictionaryWithContentsOfFile:file];
    [exceptions setValue:@(0) forKey:@"exceptionTime"];
    [exceptions writeToFile:file atomically:YES];
}

+ (BOOL)isAppCrashedOnStartUpExceedTheLimit {
    
    NSString *file = [self getFile];
    NSMutableDictionary *exceptions = [NSMutableDictionary dictionaryWithContentsOfFile:file];
    NSInteger exceptionTime = [exceptions[@"exceptionTime"] integerValue];
    if (exceptionTime > 4) {
        
        return YES;
    } else {
        
        return NO;
    }
}


@end
