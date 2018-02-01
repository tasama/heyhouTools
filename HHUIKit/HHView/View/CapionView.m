//
//  CapionView.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 12/10/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "CapionView.h"
#import <objc/runtime.h>
#import <HHFoundation/HHConst.h>
#import "NSString+Size.h"
#import "UIView+Frame.h"
#import "HHUIConst.h"

@interface CapionView ()

@property (nonatomic , strong)UILabel *contentLabel;
@property (nonatomic , assign)CGFloat textWidth;
@property (nonatomic , assign)CGFloat textHeight;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subStringLabel;

@end

@implementation CapionView

- (UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        _contentLabel = [[UILabel alloc] init];
        [_contentLabel setTextColor:[UIColor whiteColor]];
        [_contentLabel setFont:[UIFont systemFontOfSize:15.f]];
        [_contentLabel setTextAlignment:NSTextAlignmentCenter];
        [_contentLabel setNumberOfLines:2];
    }
    return _contentLabel;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:17.f]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setNumberOfLines:1];
    }
    
    return _titleLabel;
}

- (UILabel *)subStringLabel
{
    if (!_subStringLabel) {
        _subStringLabel = [[UILabel alloc]init];
        [_subStringLabel setTextColor:[UIColor whiteColor]];
        [_subStringLabel setFont:[UIFont systemFontOfSize:17.f]];
        [_subStringLabel setTextAlignment:NSTextAlignmentCenter];
        [_subStringLabel setNumberOfLines:1];
    }
    
    return _subStringLabel;
}


+ (instancetype)shareManager
{
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
    });
    return manager;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.contentLabel];
        [self addSubview:self.titleLabel];
        [self addSubview:self.subStringLabel];
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.5f]];
    }
    return self;
}

- (void)showText:(NSString *)text
{
    _contentLabel.hidden = NO;
    _titleLabel.hidden = YES;
    _subStringLabel.hidden = YES;
    [_contentLabel setText:text];
    _textWidth = MIN([text stringWidthWithFont:[UIFont systemFontOfSize:15.f] height:20] + 60, SCREEN_WIDTH - 60);
    _textHeight = [text stringHeightWithFont:[UIFont systemFontOfSize:15.f] width:_textWidth];
    
    self.alpha = 0.0;
    [self setFrame:CGRectMake(0, 0, _textWidth, MIN(_textHeight + 25, 60))];
    [self setCenter:CGPointMake(SCREEN_WIDTH * .5, SCREEN_HEIGHT * .5)];
    self.layer.cornerRadius = self.zf_height * .5f;
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(hide) withObject:nil afterDelay:2.0];
    }];
}

- (void)showTextInCenter:(NSString *)text
{
    _contentLabel.hidden = NO;
    _titleLabel.hidden = YES;
    _subStringLabel.hidden = YES;
    [_contentLabel setText:text];
    _textWidth = MIN([text stringWidthWithFont:[UIFont systemFontOfSize:15.f] height:20] + 60, SCREEN_WIDTH - 60);
    _textHeight = [text stringHeightWithFont:[UIFont systemFontOfSize:15.f] width:_textWidth];
    
    self.alpha = 0.0;
    [self setFrame:CGRectMake(0, 0, _textWidth, MIN(_textHeight + 25, 60))];
    [self setCenter:CGPointMake(SCREEN_WIDTH * .5, SCREEN_HEIGHT * .4)];
    self.layer.cornerRadius = self.zf_height * .5f;

    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(hide) withObject:nil afterDelay:2.0];
    }];
}

- (void)showTextTitle:(NSString *)title andSubString:(NSString *)subString {
    
    _contentLabel.hidden = YES;
    _titleLabel.hidden = NO;
    _subStringLabel.hidden = NO;
    [_titleLabel setText:title];
    [_subStringLabel setText:subString];
    
    self.alpha = 0.0;
    [self setFrame:CGRectMake(0, 0, 143, 143)];
    [self setCenter:CGPointMake(SCREEN_WIDTH * .5f, SCREEN_HEIGHT * .5f)];
    self.layer.cornerRadius = 20.0f;

    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(hide) withObject:nil afterDelay:1.5];
    }];
}

- (void)hide
{
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_contentLabel setFrame:CGRectMake(self.zf_height * .5, 0, self.zf_width - self.zf_height, self.zf_height)];
    [_titleLabel setFrame:CGRectMake(0, 43, self.zf_width, 20)];
    [_subStringLabel setFrame:CGRectMake(0, _titleLabel.zf_bottom + 25, self.zf_width, 20)];
}

@end
