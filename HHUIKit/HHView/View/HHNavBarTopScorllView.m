//
//  HHNavBarTopScorllView.m
//  FunnyTicket
//
//  Created by tasama on 16/10/27.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "HHNavBarTopScorllView.h"
#import "NSString+Size.h"
#import "UIColor+Hex.h"
#import "UIView+Frame.h"
#import "HHUIConst.h"
#import <HHFoundation/HHMarco.h>

@interface HHNavBarTopScorllView ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic , strong)NSMutableArray *btns;

@property (nonatomic, strong) UIButton *lastBtn;

@end

@implementation HHNavBarTopScorllView

- (instancetype)initWithTitles:(NSArray *)titles {
    
    if (self = [super init]) {
        
        self.titles = titles;
        
        _currentIndex = 0;
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

const static CGFloat MAXFont = 18.f;
const static CGFloat MinFont = 15.f;
const static CGFloat LineWidth = 40.0f;

- (void)setupUI {
    
    //添加控件
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.line];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat totalWidth = 0;
    
    for (NSString *title in self.titles) {
        
        CGFloat singleWidth = [title stringWidthWithFont:[UIFont systemFontOfSize:MAXFont weight:UIFontWeightMedium] height:20] + 25;
        totalWidth += singleWidth;
    }
    
    CGFloat startX = self.zf_width > totalWidth ? (self.zf_width - totalWidth) * .5 : 0;
    //CGFloat lastLeft = 0;
    for (int i = 0; i < [_btns count]; i ++) {
        
        UIButton *btn = _btns[i];
        NSString *title = _titles[i];
        CGFloat btnWidth = [title stringWidthWithFont:[UIFont systemFontOfSize:MAXFont weight:UIFontWeightMedium] height:20] + 25;
        btn.frame = CGRectMake(startX, 0, btnWidth, self.zf_height);
        //lastLeft = btn.zf_right;
        startX = btn.zf_right;
        if (_currentIndex == i) {
            
            [_line setBounds:CGRectMake(0, 0, LineWidth, 2.0f)];
            [_line setCenter:CGPointMake(btn.zf_centerX, 41.5)];
        }
        self.lastBtn = btn;
    }
    self.scrollView.contentSize = CGSizeMake(totalWidth, 0);
    self.scrollView.frame = CGRectMake(0, 0, self.zf_width, 44);
}


- (void)setTitles:(NSArray *)titles {
    
    _titles = titles;
    
    [_btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_btns removeAllObjects];
    for (int i = 0; i < [titles count]; i++)
    {
        NSString *title = titles[i];
        if (!kStringIsEmpty(title))
        {
            UIButton *btn = [[UIButton alloc] init];
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHexString:@"ffffff" alpha:.6f] forState:UIControlStateNormal];
            [btn setTitleColor:HH_COLOR_TEXT_MAIN_WHITE forState:UIControlStateSelected];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:MinFont weight:UIFontWeightMedium]];
            btn.tag = i;
            [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            if (_currentIndex == i)
            {
                [btn setSelected:YES];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:MAXFont weight:UIFontWeightMedium]];
            }
            [self.btns addObject:btn];
            [self.scrollView addSubview:btn];
        }
    }
    
}

#pragma mark - 响应事件

- (void)onClick:(UIButton *)btn
{
    if (_currentIndex != btn.tag)
    {
        if (_clickedButtonAtIndex)
        {
            _clickedButtonAtIndex(btn.tag);
        }
    }
    [self setCurrentIndex:btn.tag];
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    if (currentIndex == _currentIndex)
    {
        return;
    }
    UIButton *lastBtn = _btns[_currentIndex];
    [lastBtn setSelected:NO];
    [lastBtn.titleLabel setFont:[UIFont systemFontOfSize:MinFont weight:UIFontWeightMedium]];
    UIButton *currentBtn = _btns[currentIndex];
    [currentBtn setSelected:YES];
    [currentBtn.titleLabel setFont:[UIFont systemFontOfSize:MAXFont weight:UIFontWeightMedium]];
    [UIView animateWithDuration:.3 animations:^{
        [_line setCenter:CGPointMake(currentBtn.zf_centerX, _line.zf_centerY)];
    }];

    _currentIndex = currentIndex;
}


#pragma mark - 懒加载
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
    }
    
    return _scrollView;
}

- (UILabel *)line
{
    if (!_line)
    {
        _line = [[UILabel alloc] init];
        [_line setBackgroundColor:HH_COLOR_TEXT_MAIN_WHITE];
        _line.hidden = YES;
    }
    return _line;
}

- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    
    return _btns;
}


@end
