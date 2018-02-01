//
//  HHTimerProxy.h
//  FunnyTicket
//
//  Created by 514175828@qq.com on 16/10/11.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHTimerProxy : NSProxy

@property(nonatomic , weak)id target;

- (instancetype )initWithTarget:(id )target;

@end
