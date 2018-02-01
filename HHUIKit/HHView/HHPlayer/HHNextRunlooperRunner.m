//
//  ZFNextRunlooperRunner.m
//  ZFPlayer_Demo
//
//  Created by XiaoZefeng on 12/7/17.
//  Copyright © 2017年 HH_XiaoZefeng. All rights reserved.
//

#import "HHNextRunlooperRunner.h"

@interface HHNextRunlooperRunner ()

@property (nonatomic, copy) void(^run)();

@end

@implementation HHNextRunlooperRunner

- (void)dealloc
{
    if (_run) {
        _run();
    }
}

+ (instancetype)runner:(void(^)())run
{
    HHNextRunlooperRunner *instance = [HHNextRunlooperRunner new];
    instance.run = run;
    return instance;
}

+ (void)runBlock:(void (^)())run
{
    [HHNextRunlooperRunner runner:run];
}

@end
