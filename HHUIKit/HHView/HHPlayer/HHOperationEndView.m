//
//  HHOperationEndView.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 2/8/17.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHOperationEndView.h"
#import "UIView+Frame.h"
#import "UIButton+Create.h"

@interface HHOperationEndView ()

@property (nonatomic, strong) UIButton *replayButton;

@property (nonatomic, strong) UIButton *shareButton;

@end

@implementation HHOperationEndView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backButton];
        [self addSubview:self.replayButton];
        [self addSubview:self.shareButton];
        [self addSubview:self.moreButton];
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)layoutSubviews
{
    CGSize imageSize = self.backButton.imageView.image.size;
    self.backButton.frame = CGRectMake(0, 20, imageSize.width + 20, 44);
    self.replayButton.frame = CGRectMake(self.zf_width * .5 - 20 - 62, self.zf_height * .5 - 16.5, 62, 33);
    self.shareButton.frame = CGRectMake(self.replayButton.zf_right + 40, self.replayButton.zf_top, self.replayButton.zf_width, self.replayButton.zf_height);
    imageSize = self.moreButton.imageView.image.size;
    self.moreButton.frame = CGRectMake(self.zf_width - imageSize.width - 20, 20, imageSize.width + 20, 44);
}

#pragma mark Target Action

- (void)clickedReplay:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(operationEndViewClickedReplay:)]) {
        [_delegate operationEndViewClickedReplay:btn];
    }
}

- (void)clickedShare:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(operationEndViewClickedShare:)]) {
        [_delegate operationEndViewClickedShare:btn];
    }
}

- (void)clickedMore:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(operationEndViewClickedMore:)]) {
        [_delegate operationEndViewClickedMore:btn];
    }
}

- (void)clickedBack:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(operationEndViewClickedBack:)]) {
        [_delegate operationEndViewClickedBack:btn];
    }
}

#pragma mark - Lazy Loads

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton new];
        [_backButton setImage:[UIImage imageNamed:@"public_back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(clickedBack:) forControlEvents:UIControlEventTouchUpInside];
        _backButton.hidden = YES;
    }
    return _backButton;
}

- (UIButton *)replayButton
{
    if (!_replayButton) {
        _replayButton = [UIButton buttonWithFont:[UIFont systemFontOfSize:15.f] textColor:[UIColor whiteColor] title:@"重播" target:self event:@selector(clickedReplay:)];
        _replayButton.layer.masksToBounds = YES;
        _replayButton.layer.cornerRadius = 5;
        _replayButton.layer.borderWidth = .5;
        _replayButton.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _replayButton;
}

- (UIButton *)shareButton
{
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithFont:[UIFont systemFontOfSize:15.f] textColor:[UIColor whiteColor] title:@"分享" target:self event:@selector(clickedShare:)];
        _shareButton.layer.masksToBounds = YES;
        _shareButton.layer.cornerRadius = 5;
        _shareButton.layer.borderWidth = .5;
        _shareButton.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _shareButton;
}

- (UIButton *)moreButton
{
    if (!_moreButton) {
        _moreButton = [UIButton new];
        [_moreButton setImage:[UIImage imageNamed:@"public_more"] forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(clickedMore:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

@end
