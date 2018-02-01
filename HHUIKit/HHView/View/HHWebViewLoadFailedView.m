//
//  HHWebViewLoadFailedView.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 2017/3/23.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import "HHWebViewLoadFailedView.h"
#import "UIView+Frame.h"
#import "HHUIConst.h"
#import "UILabel+Create.h"
#import "UIColor+Hex.h"
#import "UIButton+Create.h"

@implementation HHWebViewLoadFailedView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = _imageView.image.size;
    _imageView.frame = CGRectMake(75 * ScreenWidthScale, self.zf_height * .5 - size.height * .5, size.width, size.height);
    
    _reloadButton.frame = CGRectMake(_imageView.zf_right + 15, _imageView.zf_centerY, 65, 28);
    
    _label.frame = CGRectMake(_reloadButton.zf_left, _reloadButton.zf_top - 45, 100, 45);
}

- (void)clickReload:(UIButton *)btn {
    if (_reload) {
        _reload();
    }
}

- (void)setupSubviews {
    [self addSubview:self.imageView];
    [self addSubview:self.label];
    [self addSubview:self.reloadButton];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.image = ImageNamed(@"search_failed_icon");
    }
    return _imageView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel labelWithFont:[UIFont systemFontOfSize:15.f] textColor:HH_COLOR_TEXT_PLACEHOLDER];
        _label.text = @"加载失败啦~";
    }
    return _label;
}

- (UIButton *)reloadButton {
    if (!_reloadButton) {
        _reloadButton = [UIButton buttonWithFont:[UIFont systemFontOfSize:12.f] textColor:HH_COLOR_TEXT_PLACEHOLDER title:@"重新加载" target:self event:@selector(clickReload:)];
        _reloadButton.layer.cornerRadius = 5;
        _reloadButton.layer.borderWidth = .5;
        _reloadButton.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
    }
    return _reloadButton;
}

@end
