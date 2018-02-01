//
//  HHAlphaView.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 9/12/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "HHAlphaView.h"

@implementation HHAlphaView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *superView = [super hitTest:point withEvent:event];
    if (superView == self) {
        return nil;
    }
    return superView;
}

@end
