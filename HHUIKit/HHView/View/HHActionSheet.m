//
//  HHActionSheet.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 14/10/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "HHActionSheet.h"
#import <UIImage+BlurEffects.h>
#import "UIColor+Hex.h"
#import "HHUIConst.h"
#import "NSString+Size.h"
#import "UIView+Frame.h"
#import <HHFoundation/HHMarco.h>
#import "UIImage+Image.h"

@interface HHActionSheet ()

@property (nonatomic , strong)UIView *contentView;
@property (nonatomic , strong)UILabel *titleLabel;
@property (nonatomic , strong)UIButton *cancelBtn;//
@property (nonatomic , strong)NSMutableArray *btns;
@property (nonatomic , strong)NSArray *titles;
@property (nonatomic , strong)UILabel *topLine;
@property (nonatomic , strong)NSMutableArray *lines;
@property (nonatomic , assign)CGFloat contentHeight;
@property (nonatomic, strong) UIView *spaceView;
@property (nonatomic, strong) UIImageView *cover;
@property (nonatomic, strong) UIView *superViewNew;
@end

@implementation HHActionSheet

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    [super willMoveToSuperview:newSuperview];
    _superViewNew = newSuperview;
}

- (UIImageView *)cover {
    if (!_cover) {
        _cover = [UIImageView new];
        _cover.backgroundColor = [UIColor clearColor];
        _cover.contentMode = UIViewContentModeBottom;
        _cover.clipsToBounds = YES;
    }
    return _cover;
}

- (UIView *)spaceView {
    if (!_spaceView) {
        _spaceView = [UIView new];
        _spaceView.backgroundColor = [UIColor clearColor];
    }
    return _spaceView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        [_contentView setBackgroundColor:[UIColor clearColor]];
        _contentView.clipsToBounds = YES;
    }
    return _contentView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setFont:[UIFont systemFontOfSize:15.f]];
        [_titleLabel setTextColor:HH_COLOR_TEXT_MAIN_BLACK];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:18.f]];
        [_cancelBtn setTitleColor:HH_COLOR_TEXT_MAIN_BLACK forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
    }
    return _cancelBtn;
}

- (UILabel *)topLine {
    if (!_topLine) {
        _topLine = [[UILabel alloc] init];
        [_topLine setBackgroundColor:[UIColor clearColor]];

    }
    return _topLine;
}

- (instancetype)initWithTitle:(NSString *)title delegate:(id<HHActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super init];
    if (self) {
        [self addSubview:self.cover];
        [self addSubview:self.contentView];
        _btns = @[].mutableCopy;
        _lines = @[].mutableCopy;
        _delegate = delegate;
        _contentHeight = 0;
        CGFloat btnHeight = 52;
        if (!kStringIsEmpty(title)) {
            [_contentView addSubview:self.titleLabel];
            [_titleLabel setText:title];
            [_contentView addSubview:self.topLine];
            CGFloat height = [title stringHeightWithFont:[UIFont systemFontOfSize:15.f] width:SCREEN_WIDTH - 40];
            _contentHeight += (20 + height);
        }
        if (!kStringIsEmpty(cancelButtonTitle)) {
            [_contentView addSubview:self.cancelBtn];
            [_contentView addSubview:self.spaceView];
            [_cancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
            _contentHeight += (5 + btnHeight);
        }
        if (!kStringIsEmpty(destructiveButtonTitle)) {
            NSMutableArray *titles = @[destructiveButtonTitle].mutableCopy;
            if (!kStringIsEmpty(otherButtonTitles)) {
                [titles addObject:otherButtonTitles];
                va_list args;
                va_start(args, otherButtonTitles);
                if (otherButtonTitles) {
                    NSString *otherButtonTitle;
                    while ((otherButtonTitle = va_arg(args, NSString *))) {
                        [titles addObject:otherButtonTitle];
                    }
                }
                va_end(args);
            }
            _contentHeight += [titles count] * btnHeight;
            [self setTitles:titles];
        }
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.5]];
    }
    return self;
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    
    [_btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_lines makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_btns removeAllObjects];
    [_lines removeAllObjects];
    
    for (int i = 0; i < [titles count]; i++) {
        NSString *title = titles[i];
        if (!kStringIsEmpty(title)) {
            UIButton *btn = [[UIButton alloc] init];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:17.f]];
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:HH_COLOR_TEXT_MAIN_BLACK forState:UIControlStateNormal];
            //[btn setBackgroundColor:[UIColor whiteColor]];
            btn.tag = i;
            [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            [_btns addObject:btn];
            [_contentView addSubview:btn];
        }
    }
    NSInteger lineCount = [_btns count] - 1;
    if (lineCount > 0) {
        for (int i = 0; i < lineCount; i++) {
            UILabel *line = [[UILabel alloc] init];
            [line setBackgroundColor:[UIColor clearColor]];
            [_lines addObject:line];
            [_contentView addSubview:line];
        }
    }
    [_cancelBtn setTag:[_btns count]];
    CGFloat btnHeight = 52;
    _contentHeight = btnHeight + 5 + (titles.count) * (btnHeight + 10);
    if (_titleLabel) {
        CGFloat height = [_titleLabel.text stringHeightWithFont:[UIFont systemFontOfSize:15.f] width:SCREEN_WIDTH - 40];
        _contentHeight += (20 + height);
    }
}

- (NSString *)titleWithBtnIndex:(NSInteger)index {
    if (index >= self.titles.count) return nil;
    return [self.titles objectAtIndex:index];
}

- (void)addTitles:(NSArray *)titles {
    if (kArrayIsEmpty(titles)) return;
    NSMutableArray *mutableTitles = @[].mutableCopy;
    for (int i = 0; i < [titles count]; i++) {
        NSString *title = titles[i];
        if (!kStringIsEmpty(title)) {
            UIButton *btn = [[UIButton alloc] init];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:17.f]];
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:HH_COLOR_TEXT_MAIN_BLACK forState:UIControlStateNormal];
            btn.tag = _titles.count + i;
            [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundColor:[UIColor whiteColor]];
            [_btns addObject:btn];
            [_contentView addSubview:btn];
            [mutableTitles addObject:title];
        }
    }
    
    NSInteger lineCount = [_btns count] - 1;
    if (lineCount > 0) {
        for (int i = 0; i < lineCount; i++) {
            UILabel *line = [[UILabel alloc] init];
            [line setBackgroundColor:[UIColor blackColor]];
            [_lines addObject:line];
            [_contentView addSubview:line];
        }
    }
    [_cancelBtn setTag:[_btns count]];

    self.titles = mutableTitles.copy;
}

- (void)onClick:(UIButton *)btn {
    if ([_delegate respondsToSelector:@selector(HHActionSheet:clickedButtonAtIndex:)]) {
        [_delegate HHActionSheet:self clickedButtonAtIndex:btn.tag];
    }
    [self hide];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (point.y < _contentView.zf_top) [self hide];
}

- (void)show {

    [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    [UIView animateWithDuration:.3 animations:^{

        if (@available(iOS 11, *)) {
            _contentView.zf_top -= (_contentHeight + self.superViewNew.safeAreaInsets.bottom);
            _cover.zf_top -= (_contentHeight + self.superViewNew.safeAreaInsets.bottom);
        } else {
            
            _contentView.zf_top -= _contentHeight;
            _cover.zf_top -= _contentHeight;
        }
    }];
}

- (void)hide {
    [UIView animateWithDuration:.3 animations:^{
        
        if (@available(iOS 11, *)) {
            
            _contentView.zf_top = _contentView.zf_top + _contentHeight + self.superViewNew.safeAreaInsets.bottom;
            _cover.zf_top = _contentView.zf_top + _contentHeight + self.superViewNew.safeAreaInsets.bottom;
        } else {
            
            _contentView.zf_top = _contentView.zf_top + _contentHeight;
            _cover.zf_top = _contentView.zf_top + _contentHeight;
        }
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //CGFloat viewHeight = 0;
    CGFloat btnHeight = 52;
    //if (_titleLabel) viewHeight += btnHeight * 5 / 6;
    //viewHeight += btnHeight * [_btns count];
    
    //CGFloat bottomOffset = 0;//距离底部34像素
    //if (_cancelBtn) bottomOffset += (5 + btnHeight);
    //
    CGFloat originX = 0;
    [_contentView setFrame:CGRectMake(originX, self.zf_height - _contentHeight, self.zf_width - originX * 2, _contentHeight)];//- viewHeight - bottomOffset
    if (@available(iOS 11, *)) {
        
        [_contentView setFrame:CGRectMake(originX, self.zf_height - _contentHeight - self.superViewNew.safeAreaInsets.bottom, self.zf_width - originX * 2, _contentHeight)];
    }
    _cover.frame = _contentView.frame;
    CGRect rect = CGRectZero;
    if (_titleLabel) {
        CGFloat height = [_titleLabel.text stringHeightWithFont:[UIFont systemFontOfSize:15.f] width:SCREEN_WIDTH - 40];
        height = 20 + height;
        [_titleLabel setFrame:CGRectMake(20, 0, _contentView.zf_width - 40, height)];
        [_topLine setFrame:CGRectMake(0, _titleLabel.zf_bottom, _contentView.zf_width, .5)];
        rect = _topLine.frame;
    }
    for (int i = 0; i < [_btns count]; i++) {
        UIButton *btn = _btns[i];
        [btn setFrame:CGRectMake(10, rect.origin.y + rect.size.height + i * (btnHeight + 10), _contentView.zf_width - 20, btnHeight)];
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.cornerRadius = 14.0f;
        btn.layer.masksToBounds = YES;
    }
    CGFloat topLineBottom = _topLine ? _topLine.zf_bottom : 0;
    for (int i = 0; i < [_lines count]; i++) {
        UILabel *line = _lines[i];
        [line setFrame:CGRectMake(0, btnHeight * (i + 1) + topLineBottom, _contentView.zf_width, .5)];
    }
    if (_cancelBtn) {
        _spaceView.frame = CGRectMake(_contentView.zf_left, _contentView.zf_height - btnHeight - 5, _contentView.zf_width, 5);
        [_cancelBtn setFrame:CGRectMake(10, _spaceView.zf_bottom, _spaceView.zf_width - 20, btnHeight)];
        _cancelBtn.layer.cornerRadius = 14.0f;
        _cancelBtn.layer.masksToBounds = YES;
    }
}

@end
