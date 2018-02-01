//
//  HHAutoScrollTitleView.m
//  LoadingProgressAnimation
//
//  Created by Xun on 17/4/25.
//  Copyright © 2017年 Xun. All rights reserved.
//

#import "HHAutoScrollTitleView.h"
#import "UIView+Frame.h"

@interface HHAutoScrollTitleView ()

@property (nonatomic, strong) UILabel *lab1;

@property (nonatomic, strong) UILabel *lab2;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) CABasicAnimation *animation;

@end

@implementation HHAutoScrollTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.clipsToBounds = YES;
        [self addSubview:self.containerView];
        [self.containerView addSubview:self.lab1];
        [self.containerView addSubview:self.lab2];
    }
    return self;
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.clipsToBounds = YES;
        [self addSubview:self.containerView];
        [self.containerView addSubview:self.lab1];
        [self.containerView addSubview:self.lab2];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    CGRect rect = self.bounds;

    self.containerView.frame = self.bounds;
    
    CGSize textSize = [self.lab2 sizeThatFits:CGSizeMake(CGFLOAT_MAX, rect.size.height)];
    
    if (textSize.width > self.zf_width) {
        
        self.containerView.zf_width = textSize.width * 2;
    }

    self.lab1.frame = CGRectMake(0, 0, textSize.width, rect.size.height);
    self.lab2.frame = CGRectMake(textSize.width, 0, textSize.width, rect.size.height);
    
    self.lab2.hidden = YES;
    
    [super layoutSubviews];
}

- (void)start {
    
    [self stop];
    
    if (self.lab1.zf_width > self.zf_width && _speed > 0) {
        
        self.lab2.hidden = NO;
        self.animation.fromValue = @(0);
        self.animation.toValue = @(-self.lab1.zf_width);
        self.animation.duration = self.lab1.zf_width / _speed;
        [self.containerView.layer addAnimation:self.animation forKey:@"translation"];
    }
}

- (void)stop {
    
    [self.containerView.layer removeAnimationForKey:@"translation"];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    [super willMoveToSuperview:newSuperview];
    
}

#pragma mark - Getter & Setter

- (void)setText:(NSString *)text {
    
    self.lab2.text = text;
    self.lab1.text = text;
    
    _text = text;
    
    [self setNeedsLayout];
}

- (void)setColor:(UIColor *)color {
    
    self.lab1.textColor = color;
    self.lab2.textColor = color;
    
    _color = color;
}

- (void)setFont:(UIFont *)font {
    
    self.lab2.font = font;
    self.lab1.font = font;
    
    _font = font;

    [self setNeedsLayout];
    
    [self start];
}

- (UILabel *)lab1 {
    
    if (!_lab1) {
        
        _lab1 = [[UILabel alloc] init];
    }
    
    return _lab1;
}

- (UILabel *)lab2 {
    
    if (!_lab2) {
        
        _lab2 = [[UILabel alloc] init];
    }
    
    return _lab2;
}

- (CABasicAnimation *)animation {
    
    if (!_animation) {
        
        _animation = [CABasicAnimation animation];
        _animation.keyPath = @"transform.translation.x";
        _animation.repeatCount = CGFLOAT_MAX;
        _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        _animation.removedOnCompletion = NO;
        _animation.fillMode = kCAFillModeBoth;
    }
    
    return _animation;
}

- (UIView *)containerView {
    
    if (!_containerView) {
        
        _containerView = [[UIView alloc] init];
    }
    
    return _containerView;
}

@end
