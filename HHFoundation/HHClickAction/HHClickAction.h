//
//  HHClickAction.h
//  FunnyTicket
//
//  Created by tasama on 17/5/3.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHConst.h"

@interface HHClickAction : NSObject

@property (nonatomic, strong, nonnull) void (^uploadEvent)(NSString *);

// TODO:
@property (nonatomic, copy) NSString *appID; //后台区分数据埋点的标志

+ (void)setEventMaxCount:(NSInteger)maxCount;

+ (instancetype)shareClick;

+ (void)event:(NSString *)event andObject:(NSDictionary *_Nullable)object;

+ (void)bootUp;

@end
