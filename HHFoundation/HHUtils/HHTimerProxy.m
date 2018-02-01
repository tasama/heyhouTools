//
//  HHTimerProxy.m
//  FunnyTicket
//
//  Created by 514175828@qq.com on 16/10/11.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "HHTimerProxy.h"

@implementation HHTimerProxy

-(instancetype)initWithTarget:(id)target
{
    _target = target;
    
    return self;
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    return _target;
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    void *nullPointer = NULL;
    [invocation setReturnValue:&nullPointer];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

@end
