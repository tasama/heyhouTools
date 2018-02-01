//
//  HHFSScrollTableView.m
//  FunnyTicket
//
//  Created by tasama on 17/7/17.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHFSScrollTableView.h"

typedef enum {
    
    moveStateIdty,
    moveStateDragging
    
} HHFSScrollTableVieMoveState;

@interface HHFSScrollTableView ()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) UIEdgeInsets orignalInset;

@property (nonatomic, assign) CGFloat offsetY;

@property (nonatomic, assign) HHFSScrollTableVieMoveState oldState;

@end

@implementation HHFSScrollTableView

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    [super willMoveToSuperview:newSuperview];
    
    self.delaysContentTouches = YES;
    
    self.orignalInset = UIEdgeInsetsMake(self.contentOffset.y, 0, 0, 0);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.superview touchesMoved:touches withEvent:event];
    self.oldState = moveStateDragging;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.superview touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
    self.oldState = moveStateIdty;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.superview touchesEnded:touches withEvent:event];
    
    if (self.oldState != moveStateDragging) {
        
        [super touchesEnded:touches withEvent:event];
    }
    self.oldState = moveStateIdty;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.superview touchesCancelled:touches withEvent:event];
    [super touchesCancelled:touches withEvent:event];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
    CGPoint translatePoint = [pan translationInView:self];
    
    if (fabs(translatePoint.y) > fabs(translatePoint.x)) {
        
        //纵向拖拽
        if (translatePoint.y > 0) {
            
            //向下拖拽
            if (self.contentOffset.y - self.orignalInset.top <= 0) {
                
                return NO;
            }
        }
    }
    return [super gestureRecognizerShouldBegin:gestureRecognizer];
}

@end
