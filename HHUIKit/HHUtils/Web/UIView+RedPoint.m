//
//  UIView+RedPoint.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 2017/3/20.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import "UIView+RedPoint.h"
#import <objc/runtime.h>
#import "UIView+Frame.h"
#import "UIColor+Hex.h"
#import "HHUIConst.h"

@implementation UIView (RedPoint)

const char *zfRedPointKey;

- (UIView *)getRedPoint {
    return objc_getAssociatedObject(self, &zfRedPointKey);
}

- (void)setRedPoint:(UIView *)redPoint {
    objc_setAssociatedObject(self, &zfRedPointKey, redPoint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showRedPoint {
    [self showRedPointInRect:(CGRect){CGPointMake(self.zf_width - 8, 0),CGSizeMake(8, 8)}];
}

- (void)showRedPointInRect:(CGRect)rect {
    UIView *view = [self getRedPoint];
    if (!view) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = HH_COLOR_RED;
        view.layer.masksToBounds = YES;
        view.frame = rect;
        view.layer.cornerRadius = view.zf_height * .5;
        [self addSubview:view];
        [self setRedPoint:view];
    }
    view.hidden = NO;
}

- (void)hideRedPoint {
    UIView *view = [self getRedPoint];
    if (!view) {
        return;
    }
    view.hidden = YES;
}

@end
