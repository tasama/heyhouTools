//
//  HHRefreshView.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 7/11/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "HHRefreshView.h"
#import "UIColor+Hex.h"
#import "UIView+Frame.h"
#import "HHUIConst.h"

@interface HHRefreshView ()
@property (nonatomic , strong)UIImageView *imageView;
@property (nonatomic , strong)UILabel *label;
@end

@implementation HHRefreshView

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [_imageView setImage:[UIImage imageNamed:@"click_the_refresh"]];
        [_imageView setUserInteractionEnabled:YES];
    }
    return _imageView;
}
- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [_label setFont:[UIFont systemFontOfSize:20.f]];
        [_label setTextColor:ThemeTextColor];
        [_label setText:@"点击刷新"];
        [_label setAdjustsFontSizeToFitWidth:YES];
        [_label setMinimumScaleFactor:.8];
    }
    return _label;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
        [self addSubview:self.label];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)tap
{
    if (_didRefresh) {
        _didRefresh();
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_imageView setFrame:CGRectMake(0, 0, self.zf_width * .2, self.zf_width * .2)];
    [_imageView setCenter:CGPointMake(self.zf_width * .5, self.zf_height * .5 - 17.5)];
    [_label setFrame:CGRectMake(0, _imageView.zf_bottom + 15, self.zf_width, 20)];
}

@end
