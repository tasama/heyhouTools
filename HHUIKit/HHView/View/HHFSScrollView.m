//
//  HHFSScrollView.m
//  TestScrollView
//
//  Created by tasama on 17/7/17.
//  Copyright © 2017年 tasama. All rights reserved.
//

#import "HHFSScrollView.h"

@interface HHFSScrollView ()<UIGestureRecognizerDelegate> {
    
    NSMutableArray *_defaultLevelView;
    NSMutableArray *_highLevelView;
    NSMutableArray *_lowLevelView;
}

@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end

@implementation HHFSScrollView

- (void)dealloc {
    
    @try {
        
        [self.pan removeObserver:self forKeyPath:@"state" context:nil];
        [self removeObserver:self forKeyPath:@"bounds" context:nil];
    } @catch (NSException *exception) {
        
    }
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor clearColor];
        [self addPan];
    }
    return self;
}

- (void)addPan {
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureDidMove:)];
    
    pan.delegate = self;
    [pan addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:nil];
    
    [self addGestureRecognizer:pan];
    self.pan = pan;
}

- (void)addSubview:(UIView *)view {
    
    [super addSubview:view];
    
    switch (view.level) {
            
        case speedLevelLow: {
            
            if (!_lowLevelView) {
                
                _lowLevelView = @[].mutableCopy;
            }
            [_lowLevelView addObject:view];
        }
            
            break;
            
        case speedLevelDefault: {
            
            if (!_defaultLevelView) {
                
                _defaultLevelView = @[].mutableCopy;
            }
            [_defaultLevelView addObject:view];
        }
            
            break;
            
        case speedLevelHigh: {
            
            if (!_highLevelView) {
                
                _highLevelView = @[].mutableCopy;
            }
            [_highLevelView addObject:view];
        }
            
            break;
            
        default:
            break;
    }
}

- (void)gestureDidMove:(UIPanGestureRecognizer *)gesture {
    
    CGPoint point = [gesture translationInView:self];
    
    CGRect bounds = self.bounds;
    
    if ((self.bounds.origin.x - point.x / 2.0f) < 0) {
        
        point.x = self.bounds.origin.x * 2.0f;
    }
    
    if ((self.bounds.origin.x - point.x / 2.0f) > (self.contentSize.width - self.bounds.size.width)) {
        
        point.x = (self.bounds.origin.x - self.contentSize.width + self.bounds.size.width) * 2.0f;
    }
    
    self.bounds = CGRectMake(bounds.origin.x - point.x / 2.0f, 0, bounds.size.width, bounds.size.height);
    
    [gesture setTranslation:CGPointZero inView:self];
    
    for (UIView *view in _lowLevelView) {
        
        CGRect originalFrame = view.frame;
        view.frame = CGRectMake(originalFrame.origin.x - point.x / 4.0f, originalFrame.origin.y, originalFrame.size.width, originalFrame.size.height);
    }
    
    for (UIView *view in _highLevelView) {
        
        CGRect originalFrame = view.frame;
        view.frame = CGRectMake(originalFrame.origin.x + point.x / 2.0f, originalFrame.origin.y, originalFrame.size.width, originalFrame.size.height);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"state"]) {
        
        UIGestureRecognizerState state = [change[@"new"] integerValue];
        
        if (state == UIGestureRecognizerStateEnded) { //跳个人主页
            
            if (self.bounds.origin.x > self.frame.size.width / 4.0f) {
                
                [self nextPageAction];
            } else { //返回当前页
                
                [self backAction];
            }
        }
    }
    
    if ([keyPath isEqualToString:@"bounds"]) {
        
        CGFloat offsetX = [change[@"new"] CGRectValue].origin.x;
        //拖动中
        if ([self.delegate respondsToSelector:@selector(HHFSScrollViewDidScrollingWithScrollView:)]) {
            
            [self.delegate HHFSScrollViewDidScrollingWithScrollView:self];
        }
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    UIPanGestureRecognizer *gesture = (UIPanGestureRecognizer *)gestureRecognizer;
    
    CGPoint translation = [gesture translationInView:self];
    
    CGFloat absX = fabs(translation.x);
    CGFloat absY = fabs(translation.y);

    if (absX > absY ) {
        
        if (translation.x < 0) {
            
            //向左滑动
            return YES;
        } else {
            
            //向右滑动
            CGRect bounds = self.bounds;
            
            if ((self.bounds.origin.x - translation.x / 2.0f) < 0) {
                
                return NO;
            } else {
                
                return YES;
            }
        }
        
    } else if (absY > absX) {

        return NO;
    }
    return YES;
}

- (void)backAction {
    
    [UIView animateWithDuration:.25f animations:^{
        
        self.bounds = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        
        for (UIView *view in _highLevelView) {
            
            CGRect originalFrame = view.frame;
            view.frame = CGRectMake(self.bounds.size.width, originalFrame.origin.y, originalFrame.size.width, originalFrame.size.height);
        }
        
        for (UIView *view in _lowLevelView) {
            
            CGRect originalFrame = view.frame;
            view.frame = CGRectMake(self.frame.size.width / 4.0f, originalFrame.origin.y, originalFrame.size.width, originalFrame.size.height);
        }
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            if ([self.delegate respondsToSelector:@selector(HHFSScrollViewDidEndDraggingWithState:)]) {
                
                [self.delegate HHFSScrollViewDidEndDraggingWithState:NO];
            }
        }
    }];
}

@end
