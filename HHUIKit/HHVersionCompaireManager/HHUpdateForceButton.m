//
//  HHUpdateForceButton.m
//  FunnyTicket
//
//  Created by tasama on 17/5/31.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHUpdateForceButton.h"
#import "UIColor+Hex.h"
#import "UIView+Frame.h"
#import "UIImage+Color.h"

@interface HHUpdateForceButton ()

@property (nonatomic, weak) id target;

@property (nonatomic, assign) SEL action;

@property (nonatomic, strong) UIButton *coverBtn;

@end

@implementation HHUpdateForceButton

- (void)addTarget:(id)target WithAction:(SEL)action {
    
    self.target = target;
    self.action = action;
    
    [self.coverBtn addTarget:self.target action:self.action forControlEvents:UIControlEventTouchUpInside];
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self setUpUI];
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setUpUI {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backImageView];
    [self addSubview:self.btnLabel];
    [self addSubview:self.coverBtn];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.btnLabel.frame = CGRectMake(0, 0, self.zf_width, self.zf_height);
    self.backImageView.frame = CGRectMake(self.zf_width - self.zf_height, 0, self.zf_height, self.zf_height);
    self.coverBtn.frame = self.bounds;
}

- (UIButton *)coverBtn
{
    if (!_coverBtn) {
        _coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_coverBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"000000" alpha:.1f]] forState:UIControlStateHighlighted];
        [_coverBtn setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    }
    
    return _coverBtn;
}

- (UILabel *)btnLabel
{
    if (!_btnLabel) {
        _btnLabel = [[UILabel alloc]init];
        _btnLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _btnLabel;
}

- (UIButton *)backImageView {
    
    if (!_backImageView) {
        _backImageView = [[UIButton alloc] init];
    }
    
    return _backImageView;
}

@end
