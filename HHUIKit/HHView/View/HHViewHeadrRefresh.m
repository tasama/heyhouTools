//
//  HHViewHeadrRefresh.m
//  FunnyTicket
//
//  Created by tasama on 17/7/10.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHViewHeadrRefresh.h"
#import "UIColor+setGradualChangingColor.h"
#import "AnimationImageCustom.h"
#import "HHUIConst.h"
#import "UIView+Frame.h"
#import "UIColor+Hex.h"
#import "HHView.h"

@interface HHViewHeadrRefresh ()

@property (nonatomic, copy) void (^refreshBlock)();

@property (nonatomic, weak) UIView *superView;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, weak) id target;

@property (nonatomic, assign) SEL selector;

@property (nonatomic, strong) CAGradientLayer *gradLayer;

@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, assign) CGFloat rate;

@end

@implementation HHViewHeadrRefresh

BOOL flag = NO;

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    [super willMoveToSuperview:newSuperview];
    
    _superView = newSuperview;
    
    self.frame = newSuperview.bounds;
    
    CAGradientLayer *layer = [UIColor setGradualChangingColor:self fromColor:self.startColor toColor:self.endColor];
    
    if (!layer) {
        
        return;
    }
    self.gradLayer = layer;
    [self.layer insertSublayer:self.gradLayer below:_imageView.layer];
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self prepare];
    }
    return self;
}

+ (instancetype)refreshWithTarget:(id)target selector:(SEL)selector {
    
    HHViewHeadrRefresh *headerRefresh = [[HHViewHeadrRefresh alloc] init];

    headerRefresh.target = target;
    
    headerRefresh.selector = selector;
    
    return headerRefresh;
}

- (void)prepare {
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"danceMan%d", 0]];
    _imageView = [[UIImageView alloc] initWithImage:image];
    _imageView.frame = CGRectMake((SCREEN_WIDTH - image.size.width / 2.0f) / 2.0f, refreshHeaderHeight - image.size.height / 2.0f, image.size.width / 2.0f, image.size.height / 2.0f);
    [self addSubview:_imageView];
}

- (NSArray *)prepareGif {

    NSMutableArray *images = @[].mutableCopy;
    for (int i = 0; i < 12; i ++) {
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"danceMan%d", i]];
        [images addObject:image];
    }
    return images.copy;
}

- (void)startGifPlay {
    
    if ([_imageView isAnimating]) {
        
        return;
    }
    _imageView.animationImages = [self prepareGif];
    _imageView.animationDuration = 1.0f;
    _imageView.animationRepeatCount = CGFLOAT_MAX;
    [_imageView startAnimating];
    [self startDisplayLink];
}

- (void)stopGifPlay {
    
    if (_imageView.isAnimating) {
        
        [_imageView stopAnimating];
        [self stopDisplayLink];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([object isKindOfClass:[HHView class]]) {
        
        if ([keyPath isEqualToString:@"frame"]) {
            
            CGFloat y = [change[@"new"] CGRectValue].origin.y;
            if (y < refreshHeaderHeight) {
                
                y = refreshHeaderHeight;
                [self stopGifPlay];
                if (self.state != HHViewRefreshStateRefreshing) {
                    
                    self.state = HHViewRefreshStatePullToRefresh;
                }
            } else {

                [self startGifPlay];
                if (self.state != HHViewRefreshStateRefreshing) {
                    
                    self.state = HHViewRefreshStateReleaseStartRefresh;
                }
            }
            _imageView.zf_top = y - _imageView.zf_height;
        }
    }
}

- (void)setState:(HHViewRefreshState)state {
    
    _state = state;
}

- (void)doRefreshAction {
    
    if (self.state == HHViewRefreshStateRefreshing) {
        
        return;
    }
    if ([self.target respondsToSelector:self.selector]) {
        
        [self.target performSelector:self.selector];
        self.state = HHViewRefreshStateRefreshing;
    }
}

- (void)endRefresh {
    
    if (_refreshView) {
        
        [UIView animateWithDuration:.25f animations:^{
           
            _refreshView.zf_top = 0;
        } completion:^(BOOL finished) {
            
            self.state = HHViewRefreshStateEndRefresh;
        }];
    }
}

- (void)startDisplayLink{
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self
                                                   selector:@selector(handleDisplayLink:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                           forMode:NSDefaultRunLoopMode];
}

- (void)handleDisplayLink:(CADisplayLink *)displayLink{
    //do something
    
    if (_rate + 0.01 > 1.0f) {
        
        flag = YES;
    }
    
    if (_rate - 0.01 < 0.0f) {
        
        flag = NO;
    }
    
    if (flag) {
        
        _rate -= 0.01f;
    } else {
        
        _rate += 0.01f;
    }
    
    UIColor *leftStartColor = self.startColor;//[UIColor colorWithHexString:@"FFD479" alpha:1.0f];
    UIColor *leftEndColor = [UIColor colorWithHexString:@"FFD479"];//[UIColor colorWithHexString:@"1480C4" alpha:1.0f];
    
    UIColor *rightStartColor = self.endColor;//[UIColor colorWithHexString:@"FFD479" alpha:1.0f];
    UIColor *rightEndColor = [UIColor colorWithHexString:@"FF9300"];//[UIColor colorWithHexString:@"6DC8FF" alpha:1.0f];
    
    CAGradientLayer *layer = [UIColor setGradualChangingColor:self fromColor:[UIColor changeWithRate:_rate andStartColor:leftStartColor andEndColor:leftEndColor] toColor:[UIColor changeWithRate:_rate andStartColor:rightStartColor andEndColor:rightEndColor]];
    [self.layer insertSublayer:layer below:_imageView.layer];
    
    [self.gradLayer removeFromSuperlayer];
    self.gradLayer = layer;
}

- (void)stopDisplayLink{
    [self.displayLink invalidate];
    self.displayLink = nil;
    
    CAGradientLayer *layer = [UIColor setGradualChangingColor:self fromColor:self.startColor toColor:self.endColor];
    
    if (!layer) {
        
        return;
    }
    [self.layer insertSublayer:layer below:_imageView.layer];
    [self.gradLayer removeFromSuperlayer];
    self.gradLayer = layer;
}

@end
