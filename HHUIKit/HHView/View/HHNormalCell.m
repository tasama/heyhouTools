//
//  HHNormalCell.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 2017/3/28.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import "HHNormalCell.h"
#import "UIView+Frame.h"
#import "NSString+Size.h"
#import "HHUIConst.h"
#import "UIColor+Hex.h"
#import "UILabel+Create.h"

@implementation HHNormalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.detailLabel];
        [self addSubview:self.arrowImageView];
        [self addSubview:self.line];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize size = _arrowImageView.image.size;
    _arrowImageView.frame = CGRectMake(self.zf_width - LEFT_INSET - size.width, self.zf_height * .5 - size.height * .5, size.width, size.height);
    CGFloat titleWidth = [self.titleLabel.text stringWidthWithFont:[UIFont systemFontOfSize:15.f] height:20];
    _titleLabel.frame = CGRectMake(LEFT_INSET, 0, titleWidth, self.zf_height);
    _detailLabel.frame = CGRectMake(_titleLabel.zf_right + LEFT_INSET, _titleLabel.zf_top, (_arrowImageView.hidden ? self.zf_width : _arrowImageView.zf_left) - 2 * LEFT_INSET - _titleLabel.zf_right, _titleLabel.zf_height);
    self.line.frame = CGRectMake(0, self.contentView.zf_height - .5f, self.contentView.zf_width, .5f);
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:15.f] textColor:HH_COLOR_THEME_BACKGROUND];
    }
    return _titleLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView new];
        _arrowImageView.image = ImageNamed(@"public_right_arrow");
    }
    return _arrowImageView;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:15.f] textColor:HH_COLOR_TEXT_SUB];
        _detailLabel.textAlignment = NSTextAlignmentRight;
    }
    return _detailLabel;
}

- (UILabel *)line {
    
    if (!_line) {
        
        _line = [[UILabel alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"ffffff" alpha:.2f];
    }
    return _line;
}

@end
