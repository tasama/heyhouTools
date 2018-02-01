//
//  XUNLoadingProgressAnimation.m
//  ViperArchitective
//
//  Created by xun on 17/4/24.
//  Copyright © 2017年 Xun. All rights reserved.
//

#import "XUNLoadingProgressAnimation.h"
#import "UIView+XUNFrame.h"
#define kScale  1.f
#define kScaleNum(num)  (kScale)*(num)

#pragma mark -------- Cycle

@interface _XUNLoadingProgressCycleAnimation: XUNLoadingProgressAnimation

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CATextLayer *textLayer;
@property (nonatomic, strong) CALayer *grayLayer;
@property (nonatomic, strong) CAKeyframeAnimation *keyframeAnimation;
@property (nonatomic, strong) CABasicAnimation *basicAnimation;

@end

@implementation _XUNLoadingProgressCycleAnimation

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self.layer addSublayer:self.grayLayer];
        [self.layer addSublayer:self.textLayer];
        [self.layer addSublayer:self.shapeLayer];
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        self.layer.cornerRadius = 10.f;
        self.clipsToBounds = YES;
        self.frame = CGRectMake(0, 0, kScaleNum(200), kScaleNum(200));
    }
    return self;
}

- (void)setProgress:(float)progress {
    
#define useAnimation 0
    
#if useAnimation
    
    self.basicAnimation.fromValue = @(self.progress);
    self.basicAnimation.toValue = @(progress);
    [self.shapeLayer addAnimation:self.basicAnimation forKey:nil];

    [self.layer addSublayer:self.shapeLayer];

    NSMutableArray *values = [NSMutableArray array];

    for (int i = self.progress * 100; i <= (progress > 1 ? 1 : progress) * 100; i++) {

        [values addObject:[@(i).stringValue stringByAppendingString:@"%"]];
    }

    self.keyframeAnimation.values = values;

    [self.textLayer addAnimation:self.keyframeAnimation forKey:nil];
    self.textLayer.string = values.lastObject;
    
    [self.layer addSublayer:self.textLayer];
#else
    self.shapeLayer.strokeEnd = progress;
    self.textLayer.string = [@((int)(progress * 100)).stringValue stringByAppendingString:@"%"];
#endif
    [super setProgress:progress];
    
    if (progress >= 1) {
        
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5f];
    }
}

#pragma mark - Getter & Setter

- (CALayer *)grayLayer
{
    if(!_grayLayer)
    {
        _grayLayer = [CALayer new];
        _grayLayer.borderWidth = 2.f;
        _grayLayer.borderColor = [UIColor colorWithWhite:0.7f alpha:1.f].CGColor;
        _grayLayer.frame = CGRectMake(kScaleNum(60), kScaleNum(40), kScaleNum(80), kScaleNum(80));
        _grayLayer.cornerRadius = 40.f;
        [_grayLayer masksToBounds];
    }
    return _grayLayer;
}


- (CAShapeLayer *)shapeLayer
{
    if(!_shapeLayer)
    {
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGPathAddArc(path, NULL, kScaleNum(100), kScaleNum(80), kScaleNum(39), 0, 2 * M_PI, NO);
        
        _shapeLayer = [CAShapeLayer new];
        _shapeLayer.lineWidth = 2.f;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.fillRule = kCAFillRuleEvenOdd;
        _shapeLayer.path = path;
        _shapeLayer.lineJoin = kCALineJoinRound;
        _shapeLayer.strokeColor = [UIColor redColor].CGColor;
        _shapeLayer.strokeEnd = 0;
        _shapeLayer.strokeStart = 0;
        
        CGPathRelease(path);
    }
    return _shapeLayer;
}


- (CATextLayer *)textLayer
{
    if(!_textLayer)
    {
        _textLayer = [CATextLayer new];
        _textLayer.fontSize = kScaleNum(18);
        _textLayer.font = (__bridge CFTypeRef _Nullable)([UIFont systemFontOfSize:kScaleNum(18)]);
        _textLayer.foregroundColor = [UIColor whiteColor].CGColor;
        _textLayer.alignmentMode = kCAAlignmentCenter;
        _textLayer.frame = CGRectMake(kScaleNum(60), kScaleNum(90), kScaleNum(80), kScaleNum(20));
        _textLayer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _textLayer;
}


- (CAKeyframeAnimation *)keyframeAnimation
{
    if(!_keyframeAnimation)
    {
        _keyframeAnimation = [CAKeyframeAnimation animation];
        _keyframeAnimation.keyPath = @"string";
        _keyframeAnimation.duration = 0.01f;
        _keyframeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAAnimationLinear];
//        _keyframeAnimation.removedOnCompletion = NO;
        _keyframeAnimation.fillMode = kCAFillModeBoth;
    }
    return _keyframeAnimation;
}


- (CABasicAnimation *)basicAnimation
{
    if(!_basicAnimation)
    {
        _basicAnimation = [CABasicAnimation animation];
        _basicAnimation.keyPath = @"strokeEnd";
        _basicAnimation.duration = 0.2f;
        _basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAAnimationLinear];
        _basicAnimation.removedOnCompletion = NO;
        _basicAnimation.fillMode = kCAFillModeForwards;
    }
    return _basicAnimation;
}

@end

#pragma mark -------- Factory

@implementation XUNLoadingProgressAnimation

+ (instancetype)animationWithKey:(XUNLoadingProgressKey)key {
    
    if ([key isEqualToString:XUNLoadingProgressCycle]) {
        
        _XUNLoadingProgressCycleAnimation *cycle = [[_XUNLoadingProgressCycleAnimation alloc] init];
        
        return cycle;
    }
    return nil;
}

- (void)showOnView:(UIView *)view {
    
    NSAssert(view, @"加载动画父视图不能为空");
    
    [view addSubview:self];
    
    self.progress = 0;
}

- (void)remove {
    
    [self removeFromSuperview];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.center = CGPointMake(self.superview.width / 2, self.superview.height / 2);
}

#pragma mark - Setter & Getter



@end

const XUNLoadingProgressKey XUNLoadingProgressCycle = @"XUNLoadingProgressCycle";

