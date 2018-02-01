//
//  HHNoDataView.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 7/11/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "HHNoDataView.h"
#import "UIColor+Hex.h"
#import "UIView+Frame.h"
#import "HHUIConst.h"

@interface HHNoDataView ()

@property (nonatomic , strong)UILabel *label;
@end

@implementation HHNoDataView
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}
- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [_label setFont:[UIFont systemFontOfSize:13.f]];
        [_label setTextColor:HH_COLOR_TEXT_DESCRIPTION];  
        [_label setText:@"没有更多结果"];
        [_label setAdjustsFontSizeToFitWidth:YES];
        [_label setMinimumScaleFactor:.8];
    }
    return _label;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.label];
    }
    return self;
}

- (void)setMessage:(NSString *)message {
    
    _message = message;
    
    self.label.text = message;
}

- (void)setImage:(UIImage *)image {
    
    _image = image;
    
    self.imageView.image = image;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = _imageView.image.size;
    [_imageView setFrame:CGRectMake((self.zf_width - size.width) / 2.0f, (self.zf_height - size.height) / 2.0f - 20, size.width, 10)];
    
    if (self.imageTop > 0) {
        
        _imageView.zf_top = self.imageTop;
    }
    
    [_label setFrame:CGRectMake(0, _imageView.zf_bottom + 15, self.zf_width, 20)];
}
@end
