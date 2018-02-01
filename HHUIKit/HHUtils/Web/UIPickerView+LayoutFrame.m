//
//  UIPickerView+LayoutFrame.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 19/7/16.
//  Copyright © 2016年 肖泽峰. All rights reserved.
//

#import "UIPickerView+LayoutFrame.h"
#import <objc/runtime.h>
#import "HHUIConst.h"

@implementation UIPickerView (LayoutFrame)

+ (void)hookFrameMethod
{
    Method originMethod = class_getInstanceMethod(self, @selector(setFrame:));
    Method hookMethod = class_getInstanceMethod(self, @selector(hookFrame:));
    
    method_exchangeImplementations(originMethod, hookMethod);
}

- (void)hookFrame:(CGRect )frame
{
    frame.size.width = SCREEN_WIDTH;
    [self hookFrame:frame];
}

@end
