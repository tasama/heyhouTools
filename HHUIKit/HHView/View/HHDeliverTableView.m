//
//  HHDeliverTableView.m
//  FunnyTicket
//
//  Created by tasama on 17/7/11.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHDeliverTableView.h"
#import "UIView+Frame.h"

@implementation HHDeliverTableView

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.bounces = NO;
    }
    return self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesEnded:touches withEvent:event];
    [self.superview touchesEnded:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.superview touchesMoved:touches withEvent:event];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    UIView *view = gestureRecognizer.view;
    
    CGPoint point = [gestureRecognizer locationInView:self];
    
    point = CGPointMake(0, point.y - self.contentOffset.y);
    
    CGFloat y = self.contentOffset.y < 0 ? - self.contentOffset.y : 0;
    
    bool isIn = CGRectContainsPoint(CGRectMake(0, y, view.zf_width, view.zf_height), point);
    
    if (isIn) {
        
        return YES;
    }
    
    return NO;
}


@end
