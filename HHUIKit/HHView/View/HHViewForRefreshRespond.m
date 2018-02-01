//
//  HHViewForRefreshRespond.m
//  FunnyTicket
//
//  Created by tasama on 17/7/10.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHViewForRefreshRespond.h"
#import "UIView+Frame.h"

@implementation HHViewForRefreshRespond

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = touches.anyObject;
    
    CGFloat localPointY = [touch locationInView:self].y;
    CGFloat preLocalPointY = [touch previousLocationInView:self].y;
    
    CGFloat offset = (localPointY - preLocalPointY) * ((refreshHeight - self.zf_top) / refreshHeight);
    
    if (offset < 0) {
        
        if (self.headRefreh && self.headRefreh.state == HHViewRefreshStateRefreshing) {
            
            return;
        }
    }
    
    if (self.zf_top + offset < 0) {
        
        return;
    }
    
    self.zf_top = self.zf_top + offset;
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGFloat y = 0;
    if (self.zf_top >= refreshHeaderHeight) {
        
        y = refreshHeaderHeight;
    }
    [UIView animateWithDuration:.3f delay:0 usingSpringWithDamping:.8f initialSpringVelocity:10.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.zf_top = y;
    } completion:^(BOOL finished) {
        
        if (y > 0) {
            
            if ([self.headRefreh respondsToSelector:@selector(doRefreshAction)]) {
                
                [self.headRefreh doRefreshAction];
            }
        }
    }];
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGFloat y = 0;
    if (self.zf_top > refreshHeaderHeight) {
        
        y = refreshHeaderHeight;
    }
    [UIView animateWithDuration:.3f delay:0 usingSpringWithDamping:.8f initialSpringVelocity:10.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.zf_top = y;
    } completion:nil];
    [super touchesCancelled:touches withEvent:event];
}

@end
