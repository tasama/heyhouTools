//
//  HHNoContentView.m
//  FunnyTicket
//
//  Created by heyhou on 17/4/7.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import "HHNoContentView.h"
#import "UIColor+Hex.h"
#import "UIView+Frame.h"
#import "HHUIConst.h"

@interface HHNoContentView ()
@property (nonatomic , strong)UIImageView *imageView;
@property (nonatomic , strong)UILabel *label;
@end

@implementation HHNoContentView

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [_imageView setImage:[UIImage imageNamed:@"circle_ exclamation_icon"]];
    }
    return _imageView;
}
- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [_label setFont:[UIFont systemFontOfSize:15.f]];
        [_label setTextColor:HH_COLOR_TEXT_MAIN_BLACK];
        [_label setText:@"该内容已被发布者删除"];
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
        self.backgroundColor = HH_COLOR_THEME_BACKGROUND;
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_imageView setFrame:CGRectMake((self.zf_width - 100 * ScreenWidthScale) / 2.0f, 100 * ScreenWidthScale , 100 * ScreenWidthScale, 100 * ScreenWidthScale)];
    [_label setFrame:CGRectMake(0, _imageView.zf_bottom + 15, self.zf_width, 20)];
}

- (void)setMessage:(NSString *)message
{
    _message = message;
    self.label.text = message;
}




@end
