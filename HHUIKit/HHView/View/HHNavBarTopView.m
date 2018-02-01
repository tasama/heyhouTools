//
//  HHNavBarTopView.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 14/10/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "HHNavBarTopView.h"
#import "HHTitleBtns.h"
#import "HHUIConst.h"
#import "UIColor+Hex.h"
#import "UIView+Frame.h"
#import "NSString+Size.h"
#import <HHMarco.h>
@interface HHNavBarTopView ()

@property (nonatomic , strong)NSMutableArray *btns;
@property (nonatomic , strong)NSMutableArray *widths;
@property (nonatomic , strong)UILabel *line;


@end

@implementation HHNavBarTopView

- (UILabel *)line
{
    if (!_line)
    {
        _line = [[UILabel alloc] init];
        [_line setBackgroundColor:[UIColor whiteColor]];
    }
    return _line;
}

- (instancetype)initWithTitles:(NSArray *)titles
{
    self = [super init];
    if (self)
    {
        _btns = @[].mutableCopy;
        _widths = @[].mutableCopy;
        _currentIndex = 0;
        _autoLayout = YES;
        self.lineColor = HH_COLOR_RED;
        _btnSelectColor = HH_COLOR_RED;
        _btnNormalColor = HH_COLOR_TEXT_PLACEHOLDER;
        [self setTitles:titles];
        [self addSubview:self.line];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _btns = @[].mutableCopy;
        _widths = @[].mutableCopy;
        _currentIndex = 0;
        _autoLayout = YES;
        self.lineColor = HH_COLOR_RED;
        _btnSelectColor = HH_COLOR_RED;
        _btnNormalColor = HH_COLOR_TEXT_PLACEHOLDER;
        [self addSubview:self.line];
    }
    return self;
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    [self.line setBackgroundColor:lineColor];
}
const static CGFloat MAXFont = 15.f;
const static CGFloat MinFont = 15.f;
- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    [_btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_btns removeAllObjects];
    [_widths removeAllObjects];
    if ([titles count] < 2) {
        
        self.line.hidden = YES;
    }
    UIEdgeInsets insets = UIEdgeInsetsMake(0, -8, 0, -8);
    for (int i = 0; i < [titles count]; i++)
    {
        NSString *title = titles[i];
        if (!kStringIsEmpty(title))
        {
            HHTitleBtns *btn = [[HHTitleBtns alloc] init];
            btn.titleEdgeInsets = insets;
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:_btnNormalColor forState:UIControlStateNormal];
            [btn setTitleColor:_btnSelectColor forState:UIControlStateSelected];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:MinFont]];
            btn.tag = i;
            [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            if (_currentIndex == i)
            {
                [btn setSelected:YES];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:titles.count > 1 ? MAXFont : 17.0f]];
            }
            [_btns addObject:btn];
            [self addSubview:btn];
            if (i == 0) {
               btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }
            CGFloat width = [title stringWidthWithFont:[UIFont systemFontOfSize:MAXFont * 1.0] height:20];
            [_widths addObject:@(width)];
        }
    }
}

- (void)setRedPointWithIndexs:(NSArray *)indexs {
    
    for (NSNumber *num in indexs) {
        
        NSInteger index = [num integerValue];
        HHTitleBtns *btn = _btns[index];
        [btn showRedPoint];
    }
    
}

- (void)hideRedPointWithIndexs:(NSArray *)indexs {
    
    for (NSNumber *num in indexs) {
        
        NSInteger index = [num integerValue];
        HHTitleBtns *btn = _btns[index];
        [btn hideRedPoint];
    }
}

- (void)onClick:(UIButton *)btn
{
    if (_currentIndex != btn.tag)
    {
        if (_clickedButtonAtIndex)
        {
            UIButton *currentBtn =  self.btns[_currentIndex];
            currentBtn.transform = CGAffineTransformIdentity;
            _clickedButtonAtIndex(btn.tag);
            [UIView animateWithDuration:.3 animations:^{
                btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }];
        }
    }
    [self setCurrentIndex:btn.tag];
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    if (currentIndex == _currentIndex || currentIndex > [_btns count])
    {
        return;
    }
    UIButton *lastBtn = _btns[_currentIndex];
    [lastBtn setSelected:NO];
    [lastBtn.titleLabel setFont:[UIFont systemFontOfSize:MinFont]];
    UIButton *currentBtn = _btns[currentIndex];
    [currentBtn setSelected:YES];
    [currentBtn.titleLabel setFont:[UIFont systemFontOfSize:MAXFont]];
    [UIView animateWithDuration:.3 animations:^{
        [_line setCenter:CGPointMake(currentBtn.zf_centerX, _line.zf_centerY)];
    }];
    _currentIndex = currentIndex;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat totalWidth = 0;
    for (UIButton *btn in _btns) {
        
        CGFloat titleWidth = [btn.titleLabel.text stringWidthWithFont:[UIFont systemFontOfSize:MAXFont] height:CGFLOAT_MAX];
        totalWidth += titleWidth;
    }
    CGFloat leftMargin = (self.zf_width - (totalWidth + (_btns.count - 1) * 23)) / 2.0f;
    CGFloat width = self.zf_width / [_btns count];
//    CGFloat space = 15;
//    CGFloat currentLength = 0;
    //CGFloat titleTotalWidth = [[_widths valueForKeyPath:@"sum.floatValue"] floatValue];
    //CGFloat btnSpace = (self.zf_width - titleTotalWidth - 30) / (_titles.count - 1);
    
    for (int i = 0; i < [_btns count]; i++)
    {
        UIButton *btn = _btns[i];
        if (_autoLayout == NO) {
            [btn setFrame:CGRectMake(width * i, 0, width, self.zf_height)];
        }
        else {
            
            width = [btn.titleLabel.text stringWidthWithFont:[UIFont systemFontOfSize:MAXFont] height:CGFLOAT_MAX];
            [btn setFrame:CGRectMake(leftMargin, 0, width, self.zf_height)];
            leftMargin += btn.zf_width + 23;
        }
//            [btn setFrame:CGRectMake(width * i, 0, width, self.zf_height)];
        if (_currentIndex == i)
        {
            [_line setBounds:CGRectMake(0, 0, 20, 5)];
            [_line setCenter:CGPointMake(btn.zf_centerX, self.zf_height - 2.5)];
        }
    }
}

@end
