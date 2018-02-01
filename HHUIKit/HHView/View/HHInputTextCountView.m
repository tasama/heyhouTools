//
//  HHInputTextCountView.m
//  FunnyTicket
//
//  Created by tasama on 17/2/3.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import "HHInputTextCountView.h"
#import "UIColor+Hex.h"
#import "UIView+Frame.h"
#import "HHUIConst.h"

@interface HHInputTextCountView ()

@property (nonatomic, strong) UILabel *textCountLabel;

@end

@implementation HHInputTextCountView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = self.superview.backgroundColor;
    //添加控件
    [self addSubview:self.textCountLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //填写布局约束
    [self.textCountLabel setFrame:CGRectMake(10, 0, self.zf_width - 20, self.zf_height)];
}

- (void)setNumOfLimit:(NSInteger)numOfLimit {
    
    if (_numOfLimit == 0) {
        
        _numOfLimit = numOfLimit;
        
        self.textCountLabel.text = [NSString stringWithFormat:@"0/%zd", numOfLimit];
    }
}

- (void)setCurrentNum:(NSInteger)currentNum {
    
    _currentNum = currentNum;
    
    self.textCountLabel.text = [NSString stringWithFormat:@"%zd/%zd", currentNum, self.numOfLimit];
}

#pragma mark - 懒加载
- (UILabel *)textCountLabel
{
    if (!_textCountLabel) {
        _textCountLabel = [[UILabel alloc]init];
        _textCountLabel.textColor = HH_COLOR_TEXT_SUB;
        _textCountLabel.font = [UIFont systemFontOfSize:12];
    }
    
    return _textCountLabel;
}


@end
