//
//  UIView+speedLevel.m
//  TestScrollView
//
//  Created by tasama on 17/7/17.
//  Copyright © 2017年 tasama. All rights reserved.
//

#import "UIView+speedLevel.h"
#import <objc/runtime.h>

@implementation UIView (speedLevel)

- (void)setLevel:(speedLevel)level {
    
    objc_setAssociatedObject(self, @"level", @(level), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (speedLevel)level {
    
    return [objc_getAssociatedObject(self, @"level") intValue];
}

@end
