//
//  HHAlertView.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 14/10/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "HHAlertView.h"
#import "HHTextField.h"
#import "UIColor+Hex.h"
#import "UIView+Frame.h"
#import "NSString+Size.h"
#import "HHUIConst.h"

#import <HHFoundation/HHMarco.h>

@interface HHAlertView ()<CAAnimationDelegate>
//内容试图
@property (nonatomic , strong)UIView *contentView;
//标题
@property (nonatomic , strong)UILabel *titleLabel;
//cancel button
@property (nonatomic , strong)UIButton *cancelBtn;
//other buttons
@property (nonatomic , strong)NSMutableArray *otherBtns;
//
@property (nonatomic , strong)NSArray *otherTitles;
//线
@property (nonatomic , strong)UILabel *topLine;
@property (nonatomic , strong)UILabel *midLine;
@property (nonatomic , strong)NSMutableArray *bottomLines;

@end

@implementation HHAlertView

- (UIView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[UIView alloc] init];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
        _contentView.layer.cornerRadius = 5;
    }
    return _contentView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:17.f]];
        [_titleLabel setTextColor:HH_COLOR_TEXT_MAIN_BLACK];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

- (UILabel *)messageLabel
{
    if (!_messageLabel)
    {
        _messageLabel = [[UILabel alloc] init];
        [_messageLabel setFont:[UIFont systemFontOfSize:17.f]];
        [_messageLabel setTextAlignment:NSTextAlignmentCenter];
        [_messageLabel setNumberOfLines:0];
        _messageLabel.textColor = HH_COLOR_TEXT_MAIN_BLACK;
    }
    return _messageLabel;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn)
    {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:17.f]];
        [_cancelBtn setTitleColor:HH_COLOR_TEXT_MAIN_BLACK forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UILabel *)topLine
{
    if (!_topLine)
    {
        _topLine = [[UILabel alloc] init];
        [_topLine setBackgroundColor:HH_COLOR_CC_GRAY];
    }
    return _topLine;
}
- (UILabel *)midLine
{
    if (!_midLine)
    {
        _midLine = [[UILabel alloc] init];
        [_midLine setBackgroundColor:HH_COLOR_CC_GRAY];
    }
    return _midLine;
}

- (HHTextField *)topTextField
{
    if (!_topTextField)
    {
        _topTextField = [[HHTextField alloc] init];
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
        [_topTextField setLeftView:leftView];
        [_topTextField setLeftViewMode:UITextFieldViewModeAlways];
        [_topTextField setBackgroundColor:[UIColor colorWithWhite:0 alpha:.1]];
        _topTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _topTextField;
}

- (HHTextField *)bottomTextField
{
    if (!_bottomTextField)
    {
        _bottomTextField = [[HHTextField alloc] init];
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
        [_bottomTextField setLeftView:leftView];
        [_bottomTextField setLeftViewMode:UITextFieldViewModeAlways];
        [_bottomTextField setBackgroundColor:[UIColor colorWithWhite:0 alpha:.1]];
        _bottomTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _bottomTextField;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id <HHAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.contentView];
        _otherBtns = @[].mutableCopy;
        _bottomLines = @[].mutableCopy;
        _alertViewStyle = HHAlertViewStyleDefault;
        if (!kStringIsEmpty(title))
        {
            [_contentView addSubview:self.titleLabel];
            [_titleLabel setText:title];
            //[_contentView addSubview:self.topLine];
        }
        if (!kStringIsEmpty(message))
        {
            [_contentView addSubview:self.messageLabel];
            [_messageLabel setText:message];
            if (_titleLabel) _messageLabel.font = [UIFont systemFontOfSize:13.f];
            [_contentView addSubview:self.midLine];
        }
        _delegate = delegate;
        if (!kStringIsEmpty(cancelButtonTitle))
        {
            [_contentView addSubview:self.cancelBtn];
            [self.cancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
        }
        if (!kStringIsEmpty(otherButtonTitles))
        {
            NSMutableArray *otherTitles = @[otherButtonTitles].mutableCopy;
            va_list args;
            va_start(args, otherButtonTitles);
            if (otherButtonTitles)
            {
                NSString *otherButtonTitle;
                while ((otherButtonTitle = va_arg(args, NSString *)))
                {
                    [otherTitles addObject:otherButtonTitle];
                }
            }
            va_end(args);
            [self setOtherTitles:otherTitles];
        }
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.5]];
    }
    return self;
}

- (void)setAlertViewStyle:(HHAlertViewStyle)alertViewStyle
{
    _alertViewStyle = alertViewStyle;
    if (alertViewStyle == HHAlertViewStyleSecureTextInput)
    {
        [_contentView addSubview:self.topTextField];
        [_topTextField setSecureTextEntry:YES];
    }
    else if (alertViewStyle == HHAlertViewStylePlainTextInput)
    {
        [_contentView addSubview:self.topTextField];
    }
    else if (alertViewStyle == HHAlertViewStyleLoginAndPasswordInput)
    {
        [_contentView addSubview:self.topTextField];
        [_contentView addSubview:self.bottomTextField];
        [_bottomTextField setSecureTextEntry:YES];
    }
}

- (void)show
{
    [self setFrame:[UIScreen mainScreen].bounds];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = .55;
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1., 1., 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [_contentView.layer addAnimation:animation forKey:nil];
}

- (void)hide
{
    [UIView animateWithDuration:.3 animations:^{
        [_contentView setAlpha:0.0];
        [self setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.0]];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self removeFromSuperview];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat height = 0;
    CGFloat messageHeight = 0.0;
    CGFloat messageTop = 0;
    if (_titleLabel) {
        height += 39;//标题高度50
        if (_messageLabel) {
//            messageHeight = [HHTools getStringOfHeight:_messageLabel.text Font:[UIFont systemFontOfSize:13.f] Width:self.zf_width - 100];
            messageHeight = [_messageLabel.text stringHeightWithFont:[UIFont systemFontOfSize:13.f] width:self.zf_width - 100];
            height += (messageHeight + 40);
            messageTop = 20;
        }
    } else {
        if (_messageLabel) {
//            messageHeight = [HHTools getStringOfHeight:_messageLabel.text Font:[UIFont systemFontOfSize:17.f] Width:self.zf_width - 100];
            messageHeight = [_messageLabel.text stringHeightWithFont:[UIFont systemFontOfSize:17.f] width:self.zf_width - 100];
            height += (messageHeight + 70);//上下边距25
            messageTop = 35;
        }
    }
    
    if (_cancelBtn) {
        height += 60;
    }
    height += (_alertViewStyle == HHAlertViewStyleSecureTextInput || _alertViewStyle == HHAlertViewStylePlainTextInput) ? 70 : 0;
    height += (_alertViewStyle == HHAlertViewStyleLoginAndPasswordInput) ? 130 : 0;
    [_contentView setFrame:CGRectMake(0, 0, self.zf_width - 50, height)];
    [_contentView setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width * .5, [UIScreen mainScreen].bounds.size.height * .5)];
    [_titleLabel setFrame:CGRectMake(15, 18, _contentView.zf_width - 30, 21)];
    //[_topLine setFrame:CGRectMake(0, _titleLabel.zf_bottom, _contentView.zf_width, .5)];
    if (_alertViewStyle == HHAlertViewStyleSecureTextInput || _alertViewStyle == HHAlertViewStylePlainTextInput) {
        CGRect rect = _titleLabel ? _topLine.frame : CGRectMake(0, 0, _contentView.zf_width, 0);
        [_topTextField setFrame:CGRectMake(25, rect.origin.y + rect.size.height + 20, _contentView.zf_width - 50, 50)];
    } else if (_alertViewStyle == HHAlertViewStyleLoginAndPasswordInput) {
        CGRect rect = _titleLabel ? _topLine.frame : CGRectMake(0, 0, _contentView.zf_width, 0);
        [_topTextField setFrame:CGRectMake(25, rect.origin.y + rect.size.height + 20, _contentView.zf_width - 50, 50)];
        [_bottomTextField setFrame:CGRectMake(_topTextField.zf_left, _topTextField.zf_bottom + 10, _topTextField.zf_width, _topTextField.zf_height)];
    }
    if (_messageLabel) {
        CGRect rect = _titleLabel ? _titleLabel.frame : CGRectMake(0, 0, _contentView.zf_width, 0);
        if (_alertViewStyle == HHAlertViewStyleSecureTextInput || _alertViewStyle == HHAlertViewStylePlainTextInput) {
            rect = _topTextField.frame;
        } else if (_alertViewStyle == HHAlertViewStyleLoginAndPasswordInput) {
            rect = _bottomTextField.frame;
        }
        [_messageLabel setFrame:CGRectMake(25, rect.origin.y + rect.size.height + messageTop, _contentView.zf_width - 50, messageHeight)];
        [_midLine setFrame:CGRectMake(0, _messageLabel.zf_bottom + messageTop, _contentView.zf_width, .5)];
    }
    if (_cancelBtn) {
        CGRect rect = _messageLabel ? _messageLabel.frame : (_titleLabel ? _titleLabel.frame : CGRectMake(0, 0, _contentView.zf_width, 0));
        NSInteger btnCount = [_otherBtns count] + 1;
        CGFloat btnWidth = _contentView.zf_width / btnCount;
        CGFloat offset = _messageLabel ? messageTop : 0;
        [_cancelBtn setFrame:CGRectMake(0, rect.origin.y + rect.size.height + offset, btnWidth, 60)];
        for (int i = 0; i < [_otherBtns count]; i++) {
            UIButton *otherBtn = _otherBtns[i];
            [otherBtn setFrame:CGRectMake((i + 1) * (btnWidth + .5), _cancelBtn.zf_top, btnWidth, _cancelBtn.zf_height)];
            UILabel *bottomLine = _bottomLines[i];
            [bottomLine setFrame:CGRectMake(otherBtn.zf_left, otherBtn.zf_top, .5, otherBtn.zf_height)];
        }
    }
}

- (void)setOtherTitles:(NSArray *)otherTitles
{
    _otherTitles = otherTitles;
    [_otherBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_bottomLines makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_otherBtns removeAllObjects];
    [_bottomLines removeAllObjects];
    for (int i = 0; i < [otherTitles count]; i++)
    {
        UIButton *btn = [[UIButton alloc] init];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:17.f]];
        [btn setTitleColor:HH_COLOR_TEXT_MAIN_BLACK forState:UIControlStateNormal];
        btn.tag = i + 1;
        [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        NSString *title = otherTitles[i];
        [btn setTitle:title forState:UIControlStateNormal];
        [_contentView addSubview:btn];
        [_otherBtns addObject:btn];
        
        UILabel *line = [[UILabel alloc] init];
        [line setBackgroundColor:HH_COLOR_CC_GRAY];
        [_contentView addSubview:line];
        [_bottomLines addObject:line];
    }
    [self setNeedsLayout];
}

- (void)onClick:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(HHAlertView:clickedButtonAtIndex:)])
    {
        [_delegate HHAlertView:self clickedButtonAtIndex:btn.tag];
    }
    [self hide];
}

@end
