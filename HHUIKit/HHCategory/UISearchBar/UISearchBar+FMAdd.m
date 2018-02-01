//
//  UISearchBar+FMAdd.m
//  FollowmeiOS
//
//  Created by Subo on 15/12/24.
//  Copyright © 2015年 com.followme. All rights reserved.
//

#import "UISearchBar+FMAdd.h"

#define IS_IOS9 [[UIDevice currentDevice].systemVersion doubleValue] >= 9

@implementation UISearchBar (FMAdd)


- (void)setLeftPlaceholder:(NSString *)placeholder {
    
    self.placeholder = placeholder;
    SEL centerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", @"setCenter", @"Placeholder:"]);
    if ([self respondsToSelector:centerSelector]) {
        BOOL centeredPlaceholder = NO;
        NSMethodSignature *signature = [[UISearchBar class] instanceMethodSignatureForSelector:centerSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:centerSelector];
        [invocation setArgument:&centeredPlaceholder atIndex:2];
        [invocation invoke];
    }
}

@end
