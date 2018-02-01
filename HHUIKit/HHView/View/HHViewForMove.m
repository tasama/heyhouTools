//
//  HHViewForMove.m
//  FunnyTicket
//
//  Created by tasama on 17/7/17.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHViewForMove.h"
#import "UIView+Frame.h"

@interface HHViewForMove ()

@property (nonatomic, assign) CGRect orignalFrame;

@property (nonatomic, assign) CGPoint startPoint;

@property (nonatomic, assign) CGPoint endPoint;

@property (nonatomic, weak) UIView *superViewNew;

@end

@implementation HHViewForMove

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    [super willMoveToSuperview:newSuperview];
    
    self.superViewNew = newSuperview;
    
    self.orignalFrame = newSuperview.bounds;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = touches.anyObject;
    
    self.startPoint = [touch locationInView:self.superViewNew];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = touches.anyObject;
    
    CGPoint startPoint = [touch previousLocationInView:self];
    CGPoint endPoint = [touch locationInView:self];
    
    
    CGFloat offsetY = endPoint.y - startPoint.y;
    
    if (self.zf_top + offsetY < 0) {
        
        self.zf_top = 0;
    } else {
        
        self.zf_top = self.zf_top + offsetY;
    }
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = touches.anyObject;
    
    self.endPoint = [touch locationInView:self.superViewNew];
    
    CGFloat moveY = self.endPoint.y - self.startPoint.y;
    
    if (moveY > 0) { //向下移动手指
        
        if (moveY > 100.0f) {
            //收起
            [UIView animateWithDuration:.25f animations:^{
                
                self.zf_top = self.orignalFrame.size.height;
            } completion:^(BOOL finished) {
                
                if (self.dissMissBlock) {
                    
                    self.dissMissBlock();
                }
            }];
        } else {
            
            //弹回原位
            [UIView animateWithDuration:.25f animations:^{
                
                self.frame = self.orignalFrame;
            } completion:^(BOOL finished) {
                
            }];
        }
        
    } else {
        //弹回原位
        [UIView animateWithDuration:.25f animations:^{
           
            self.frame = self.orignalFrame;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesCancelled:touches withEvent:event];
    
    [self touchesEnded:touches withEvent:event];
}

@end
