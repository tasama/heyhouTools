//
//  HHRefreshHeader.m
//  FunnyTicket
//
//  Created by tasama on 17/7/14.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHRefreshHeader.h"
#import "UIColor+setGradualChangingColor.h"
#import "AnimationImageCustom.h"
#import "UIView+Frame.h"
#import "UIColor+Hex.h"
#import "HHUIConst.h"

@interface HHRefreshHeader ()

@property (nonatomic, strong) UIImageView *refreshBackView;

@property (nonatomic, strong) UIImageView *refreshIconView;

@property (nonatomic, assign) CGFloat insetTDelta;

@property (nonatomic, assign) BOOL isAnimated;

@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, assign) CGFloat rate;

@property (nonatomic, assign) BOOL flag;

@property (nonatomic, strong) NSMutableArray *danceManIcons;

@property (nonatomic, assign) NSTimeInterval current;

@property (nonatomic, strong) UIView *effectView;

@property (nonatomic, strong) AnimationImageCustom *waveImageView;

@end

@implementation HHRefreshHeader

const CGFloat HHRefreshHeaderHeight = 64.0;

#pragma mark - 构造方法
+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    MJRefreshHeader *cmp = [[self alloc] init];
    cmp.refreshingBlock = refreshingBlock;
    return cmp;
}
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshHeader *cmp = [[self alloc] init];
    [cmp setRefreshingTarget:target refreshingAction:action];
    return cmp;
}

- (void)prepare {
    
    [super prepare];
    
    self.mj_h = SCREEN_HEIGHT;
    
    self.refreshIconView.zf_left = (SCREEN_WIDTH - 40.0f) / 2.0f;
    self.refreshIconView.zf_width = 40.0f;
    self.refreshIconView.zf_height = 40.0f;
    self.refreshIconView.zf_top = self.mj_h - 40.0f ;
}

- (void)placeSubviews {
    
    [super placeSubviews];
    
    self.mj_y = - self.mj_h - (self.ignoredScrollViewContentInsetTop > 0 ? 0 : self.ignoredScrollViewContentInsetTop);
    
    if (self.upMoveOffset > 0) {

        self.mj_y -= _upMoveOffset;
    }
    
    self.refreshBackView.zf_top = 0;
    self.refreshBackView.zf_left = 0;
    self.refreshBackView.zf_width = self.mj_w;
    self.refreshBackView.zf_height = self.mj_h;
    self.effectView.frame = self.refreshBackView.frame;
    self.waveImageView.frame = CGRectMake(0, self.mj_h - 10.0f, self.mj_w, 10.0f);
    UIImage *backImage = [UIColor drawChangingColorWithSize:self.refreshBackView.bounds.size fromColor:self.startColor ? self.startColor : [UIColor colorWithHexString:@"181818"] toColor:self.endColor ? self.endColor : [UIColor colorWithHexString:@"242424"] withLocation:CGPointZero toLocation:CGPointZero];
    self.refreshBackView.image = backImage;
    
    self.refreshIconView.image = [UIImage imageNamed:@"danceMan0"];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.mj_h - 10.0f + self.ignoredScrollViewContentInsetTop)];
    [path addQuadCurveToPoint:CGPointMake(self.mj_w, self.mj_h - 10.0f + self.ignoredScrollViewContentInsetTop) controlPoint:CGPointMake(self.mj_w / 2.0f, self.mj_h - 10.0f + self.ignoredScrollViewContentInsetTop)];
    [path addLineToPoint:CGPointMake(self.mj_w, self.mj_h)];
    [path addLineToPoint:CGPointMake(0, self.mj_h)];
    [path closePath];

    self.effectView.layer.shadowRadius = 20.0f;
    self.effectView.layer.shadowPath = path.CGPath;
    self.effectView.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.effectView.layer.shadowOpacity = 1.0f;
}

- (void)setPullingPercent:(CGFloat)pullingPercent {
    
    [super setPullingPercent:pullingPercent];
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.mj_h - 10.0f - pullingPercent * HHRefreshHeaderHeight + self.ignoredScrollViewContentInsetTop)];
    [path addQuadCurveToPoint:CGPointMake(self.mj_w, self.mj_h - 10.0f + self.ignoredScrollViewContentInsetTop - pullingPercent * HHRefreshHeaderHeight) controlPoint:CGPointMake(self.mj_w / 2.0f, self.mj_h - 10.0f + self.ignoredScrollViewContentInsetTop + pullingPercent * HHRefreshHeaderHeight)];
    [path addLineToPoint:CGPointMake(self.mj_w, self.mj_h)];
    [path addLineToPoint:CGPointMake(0, self.mj_h)];
    [path closePath];
    self.effectView.layer.shadowPath = path.CGPath;

    if (pullingPercent > 1.0f) {
        
        pullingPercent = 1.0f;
    }
    
    self.refreshIconView.alpha = pullingPercent;
    
    self.refreshIconView.mj_y = self.mj_h - 40.0f + (self.ignoredScrollViewContentInsetTop > 0 ? 0 : self.ignoredScrollViewContentInsetTop) * pullingPercent;
    
    self.effectView.alpha = pullingPercent / 3.0f;
}

- (UIImageView *)refreshBackView {
    
    if (!_refreshBackView) {
        
        _refreshBackView = [[UIImageView alloc] init];
        [self insertSubview:_refreshBackView atIndex:0];
    }
    return _refreshBackView;
}

- (UIImageView *)refreshIconView {
    
    if (!_refreshIconView) {
        
        _refreshIconView = [[UIImageView alloc] init];
        _refreshIconView.alpha = 0.0f;
        _refreshIconView.contentMode = UIViewContentModeScaleAspectFill;
        [self insertSubview:_refreshIconView aboveSubview:self.refreshBackView];
    }
    return _refreshIconView;
}

- (UIView *)effectView {
    
    if (!_effectView) {
        
        _effectView = [[UIView alloc] init];
        _effectView.backgroundColor = [UIColor clearColor];
        [self insertSubview:_effectView belowSubview:self.refreshIconView];
    }
    return _effectView;
}


- (AnimationImageCustom *)waveImageView {
    
    if (!_waveImageView) {
        
        _waveImageView = [[AnimationImageCustom alloc] init];
        _waveImageView = [[AnimationImageCustom alloc] init];
        _waveImageView.waveSpeed = 1.0f;
        _waveImageView.waveWidth = SCREEN_WIDTH;
        _waveImageView.waveHeight = 10.0f;
        _waveImageView.waveAmplitude = 2.0f;
        _waveImageView.offsetXT = 10.0f;
        _waveImageView.hidden = YES;
        [self insertSubview:_waveImageView belowSubview:self.effectView];
    }
    return _waveImageView;
}




- (NSMutableArray *)danceManIcons {
    
    if (!_danceManIcons) {
        
        _danceManIcons = @[].mutableCopy;
        for (int i = 0; i < 12; i ++) {
            
            [_danceManIcons addObject:[UIImage imageNamed:[NSString stringWithFormat:@"danceMan%d", i]]];
        }
    }
    return _danceManIcons;
}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    
    [super scrollViewPanStateDidChange:change];
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    
    [super scrollViewContentOffsetDidChange:change];
    
    // 在刷新的refreshing状态
    if (self.state == MJRefreshStateRefreshing) {
        if (self.window == nil) return;
        
        // sectionheader停留解决
        CGFloat insetT = - self.scrollView.mj_offsetY > _scrollViewOriginalInset.top ? - self.scrollView.mj_offsetY : _scrollViewOriginalInset.top;
        insetT = insetT > HHRefreshHeaderHeight + _scrollViewOriginalInset.top ? HHRefreshHeaderHeight + _scrollViewOriginalInset.top : insetT;
        self.scrollView.mj_insetT = insetT;
        
        self.insetTDelta = _scrollViewOriginalInset.top - insetT;
        return;
    }
    
    // 跳转到下一个控制器时，contentInset可能会变
    _scrollViewOriginalInset = self.scrollView.contentInset;
    
    // 当前的contentOffset
    CGFloat offsetY = self.scrollView.mj_offsetY;
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
    
    // 如果是向上滚动到看不见头部控件，直接返回
    // >= -> >
    if (offsetY >= happenOffsetY) return;

    [self startAnimation];
    // 普通 和 即将刷新 的临界点
    CGFloat normal2pullingOffsetY = happenOffsetY - HHRefreshHeaderHeight;
    CGFloat pullingPercent = (happenOffsetY - offsetY) / HHRefreshHeaderHeight;
    
    if (self.scrollView.isDragging) { // 如果正在拖拽
        self.pullingPercent = pullingPercent;
        if (self.state == MJRefreshStateIdle && offsetY < normal2pullingOffsetY) {
            // 转为即将刷新状态
            self.state = MJRefreshStatePulling;
        } else if (self.state == MJRefreshStatePulling && offsetY >= normal2pullingOffsetY) {
            // 转为普通状态
            self.state = MJRefreshStateIdle;
        }
    } else if (self.state == MJRefreshStatePulling) {// 即将刷新 && 手松开
        // 开始刷新
        [self beginRefreshing];
    } else if (pullingPercent < 1) {
        self.pullingPercent = pullingPercent;
        [self stopDisplayLink];
        [self endAnimation];
    }
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    
    [super scrollViewContentSizeDidChange:change];
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState != MJRefreshStateRefreshing) return;
        
                // 恢复inset和offset
        [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
            self.scrollView.mj_insetT += self.insetTDelta;
            self.refreshIconView.alpha = 0.0f;
            // 自动调整透明度
            if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.pullingPercent = 0.0;
            
            [self endAnimation];
            if (self.endRefreshingCompletionBlock) {
                self.endRefreshingCompletionBlock();
            }
        }];
    } else if (state == MJRefreshStateRefreshing) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self startAnimation];
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                CGFloat top = self.scrollViewOriginalInset.top + HHRefreshHeaderHeight;
                // 增加滚动区域top
                self.scrollView.mj_insetT = top;
                // 设置滚动位置
                [self.scrollView setContentOffset:CGPointMake(0, -top) animated:NO];
            } completion:^(BOOL finished) {
                [self executeRefreshingCallback];
            }];
        });
    }
}

- (void)endRefreshing
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.state = MJRefreshStateIdle;
    });
}

- (void)startAnimation {
    
    if (!self.isAnimated) {
        
        [self stopDisplayLink];
        
        if (!self.refreshIconView.isAnimating) {
            
            self.refreshIconView.animationImages = self.danceManIcons;
            self.refreshIconView.animationDuration = 1.0f;
            self.refreshIconView.animationRepeatCount = CGFLOAT_MAX;
            [self.refreshIconView startAnimating];
        }
        self.isAnimated = YES;
    }
}

- (void)endAnimation {
    
    if (self.isAnimated) {
        
        [self startDisplayLink];
        if (self.refreshIconView.isAnimating) {
            
            [self.refreshIconView stopAnimating];
        }
        self.isAnimated = NO;
    }
}

- (void)startDisplayLink{
    
    if (!self.displayLink) {
        
        self.displayLink = [CADisplayLink displayLinkWithTarget:self
                                                       selector:@selector(handleDisplayLink:)];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                               forMode:NSRunLoopCommonModes];
        
        self.current = [[NSDate date] timeIntervalSince1970];
//        [self.waveImageView wave];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(18.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            NSTimeInterval current = [[NSDate date] timeIntervalSince1970];
            if (current - self.current >= 10.0f) {
                
                [self stopDisplayLink];
//                [self.waveImageView stop];
            }
        });
    }
}


- (void)handleDisplayLink:(CADisplayLink *)displayLink{
    //do something

    if (_rate + 0.02 > 1.0f) {
        
        _flag = YES;
    }
    
    if (_rate - 0.02 < 0.0f) {
        
        _flag = NO;
    }
    
    if (_flag) {
        
        _rate -= 0.02f;
    } else {
        
        _rate += 0.02f;
    }
    
    UIColor *leftStartColor = self.startColor ? self.startColor : [UIColor colorWithHexString:@"181818"];
    UIColor *leftEndColor = self.startFinalColor ? self.startFinalColor : [UIColor colorWithHexString:@"242424"];
    
    UIColor *rightStartColor = self.endColor ? self.endColor : [UIColor colorWithHexString:@"242424"];
    UIColor *rightEndColor = self.endFinalColor ? self.endFinalColor : [UIColor colorWithHexString:@"181818"];
    
    UIImage *image = [UIColor drawChangingColorWithSize:self.bounds.size fromColor:[UIColor changeWithRate:_rate andStartColor:leftStartColor andEndColor:leftEndColor] toColor:[UIColor changeWithRate:_rate andStartColor:rightStartColor andEndColor:rightEndColor] withLocation:CGPointZero toLocation:CGPointZero];
    
    _effectView.alpha = _rate;
    
    if (!image) {
        
        return;
    }
    self.refreshBackView.image = image;
}

- (void)stopDisplayLink{
    
    [self.displayLink invalidate];
    self.displayLink = nil;
    UIImage *backImage = [UIColor drawChangingColorWithSize:self.refreshBackView.bounds.size fromColor:self.startColor ? self.startColor : [UIColor colorWithHexString:@"181818"] toColor:self.endColor ? self.endColor : [UIColor colorWithHexString:@"242424"] withLocation:CGPointZero toLocation:CGPointZero];
    self.refreshBackView.image = backImage;
    _flag = NO;
    [UIView animateWithDuration:.5f animations:^{
        
        _effectView.alpha = 0.0f;
    }];
}


@end
