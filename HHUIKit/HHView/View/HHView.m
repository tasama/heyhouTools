//
//  HHView.m
//  FunnyTicket
//
//  Created by tasama on 17/7/10.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHView.h"

@implementation HHView

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if ([self.delegate respondsToSelector:@selector(MYTouchesMoved:withEvent:)]) {
        
        [self.delegate MYTouchesMoved:touches withEvent:event];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if ([self.delegate respondsToSelector:@selector(MYTouchesBegan:withEvent:)]) {
        
        [self.delegate MYTouchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if ([self.delegate respondsToSelector:@selector(MYTouchesEnded:withEvent:)]) {
        
        [self.delegate MYTouchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if ([self.delegate respondsToSelector:@selector(MYTouchesCancelled:withEvent:)]) {
        
        [self.delegate MYTouchesCancelled:touches withEvent:event];
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    [super willMoveToSuperview:newSuperview];
    
    if (self.headRefreh) {
        
        [newSuperview insertSubview:self.headRefreh belowSubview:self];
    }
}

- (void)setHeadRefreh:(HHViewHeadrRefresh *)headRefreh {
    
    if (!_headRefreh) {
        
        _headRefreh = headRefreh;
        
    } else {
        
        [_headRefreh removeFromSuperview];
        _headRefreh = headRefreh;
    }
    if (self.superview) {
        
        [self.superview insertSubview:headRefreh belowSubview:self];
    }
    
    [self addObserver];
}

- (void)addObserver {
    
    [self addObserver:_headRefreh forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    _headRefreh.refreshView = self;
}

- (void)dealloc {
    
    if (_headRefreh) {
        
        [self removeObserver:_headRefreh forKeyPath:@"frame"];
    }
}

@end
