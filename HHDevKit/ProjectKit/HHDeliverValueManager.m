//
//  HHDeliverValueManager.m
//  FunnyTicket
//
//  Created by Xun on 17/5/19.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHDeliverValueManager.h"

@implementation HHDeliverValueManager

+ (instancetype)shareManager {
    
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static HHDeliverValueManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [super allocWithZone:zone];
    });
    
    return manager;
}

@end
