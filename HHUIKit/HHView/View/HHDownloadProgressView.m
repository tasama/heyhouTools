//
//  HHDownloadProgressView.m
//  ZF_Demo
//
//  Created by XiaoZefeng on 2/5/17.
//  Copyright © 2017年 HH_XiaoZefeng. All rights reserved.
//

#import "HHDownloadProgressView.h"
#import "UIView+Frame.h"
#import "UIButton+Create.h"
#import "HHUIConst.h"

@interface HHDownloadProgressView ()

{
    CAShapeLayer *backGroundLayer; // 背景图层
    CAShapeLayer *frontFillLayer;      // 用来填充的图层
    UIBezierPath *backGroundBezierPath; // 背景布赛尔曲线
    UIBezierPath *frontFillBezierPath;  // 用来填充的布赛尔曲线
}

@property (nonatomic, strong) UIView *contentView;

@end

@implementation HHDownloadProgressView

@synthesize progressColor = _progressColor;
@synthesize progressTrackColor = _progressTrackColor;
@synthesize progressValue = _progressValue;
@synthesize progressStrokeWidth = _progressStrokeWidth;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
        _titleLabel.text = @"获取歌曲中...";
        self.progressStrokeWidth = 3.f;
        self.progressTrackColor = [UIColor colorWithWhite:1.0 alpha:.5f];
        self.progressColor = [UIColor whiteColor];
    }
    return self;
}
/**
 *  初始化创建图层
 */
- (void)setUp {
    //创建背景图层
    backGroundLayer = [CAShapeLayer layer];
    backGroundLayer.fillColor = nil;
    
    //创建填充图层
    frontFillLayer = [CAShapeLayer layer];
    frontFillLayer.fillColor = nil;
    backGroundLayer.frame = (CGRect){CGPointMake(143 * .5 - 45 * .5 , 30), CGSizeMake(45, 45)};
    frontFillLayer.frame = (CGRect){CGPointMake(143 * .5 - 45 * .5 , 30), CGSizeMake(45, 45)};

    _contentView = [UIView new];
    _contentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
    _contentView.layer.cornerRadius = 7.5;
    [_contentView.layer addSublayer:backGroundLayer];
    [_contentView.layer addSublayer:frontFillLayer];
    [_contentView addSubview:self.titleLabel];
    [self addSubview:self.cancelButton];
    [self addSubview:_contentView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _contentView.frame = (CGRect){CGPointZero, CGSizeMake(143, 143)};
    _contentView.center = CGPointMake(CGRectGetWidth(self.frame) * .5, CGRectGetHeight(self.frame) * .5);
    
    _titleLabel.frame = CGRectMake(10, 75 + 10, _contentView.zf_width - 20, 39);
    
    CGSize size = _cancelButton.imageView.image.size;
    _cancelButton.frame = CGRectMake(self.zf_width * .5 - (size.height + 20) * .5, _contentView.zf_bottom + 5, size.height + 20, size.height + 20);
}

- (void)setProgressColor:(UIColor *)progressColor
{
    _progressColor = progressColor;
    frontFillLayer.strokeColor = progressColor.CGColor;
}

- (UIColor *)progressColor {
    return _progressColor;
}

- (void)setProgressTrackColor:(UIColor *)progressTrackColor {
    _progressTrackColor = progressTrackColor;
    backGroundLayer.strokeColor = progressTrackColor.CGColor;
    backGroundBezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(backGroundLayer.frame.size.width * .5, backGroundLayer.frame.origin.y)
                                                          radius:backGroundLayer.frame.size.width * .5
                                                      startAngle:0
                                                        endAngle:M_PI * 2
                                                       clockwise:YES];
    backGroundLayer.path = backGroundBezierPath.CGPath;
}

- (UIColor *)progressTrackColor {
    return _progressTrackColor;
}

- (void)setProgressValue:(CGFloat)progressValue {
    _progressValue = progressValue;
    frontFillBezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frontFillLayer.frame.size.width * .5, frontFillLayer.frame.origin.y)
                                                         radius:frontFillLayer.frame.size.width * .5
                                                     startAngle:-M_PI_2
                                                       endAngle:(2 * M_PI) * progressValue - M_PI_2
                                                      clockwise:YES];
    frontFillLayer.path = frontFillBezierPath.CGPath;
    if (progressValue >= 1.f) {
        //image->hidden = NO
    }
}

- (void)show {
    if (self.superview) return;
    self.frame = [UIScreen mainScreen].bounds;
    self.progressValue = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)hide {
    if (!self.superview) return;
    self.progressValue = 0;
    [self removeFromSuperview];
}

- (CGFloat)progressValue {
    return _progressValue;
}

- (void)setProgressStrokeWidth:(CGFloat)progressStrokeWidth {
    _progressStrokeWidth = progressStrokeWidth;
    frontFillLayer.lineWidth = progressStrokeWidth;
    backGroundLayer.lineWidth = progressStrokeWidth;
}

- (CGFloat)progressStrokeWidth {
    return _progressStrokeWidth;
}

- (void)clickCancel:(UIButton *)btn {
    !_clickCancelBlock ? : _clickCancelBlock(self);
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:17.f];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithImage:ImageNamed(@"fashionPhoto_cancel_normal") target:self event:@selector(clickCancel:)];
        _cancelButton.hidden = YES;
    }
    return _cancelButton;
}

@end
