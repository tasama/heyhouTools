//
//  HHPickerView.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 23/11/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "HHPickerView.h"
#import "UIColor+Hex.h"
#import "HHUIConst.h"
#import "UIView+Frame.h"
#import <HHFoundation/HHMarco.h>

@interface HHPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic , strong)UIView *contentView;
@property (nonatomic , strong)UIButton *cancelBtn;
@property (nonatomic , strong)UIButton *okBtn;
@property (nonatomic , strong)UIPickerView *pickerView;
@property (nonatomic , strong)NSString *text ;
@end

@implementation HHPickerView
- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
    }
    return _contentView;
}
- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:18.f]];
        [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"#358bff"] forState:UIControlStateNormal];
        [_cancelBtn setBackgroundColor:[UIColor whiteColor]];
        _cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _cancelBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        [_cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (UIButton *)okBtn
{
    if (!_okBtn) {
        _okBtn = [[UIButton alloc] init];
        [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_okBtn.titleLabel setFont:[UIFont systemFontOfSize:18.f]];
        [_okBtn setTitleColor:themeColor forState:UIControlStateNormal];
        [_okBtn setBackgroundColor:[UIColor whiteColor]];
        _okBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _okBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
        [_okBtn addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okBtn;
}
- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        [_pickerView setDelegate:self];
        [_pickerView setDataSource:self];
        [_pickerView setBackgroundColor:[UIColor whiteColor]];
    }
    return _pickerView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _text = @"";
        [self addSubview:self.contentView];
        [_contentView addSubview:self.cancelBtn];
        [_contentView addSubview:self.okBtn];
        [_contentView addSubview:self.pickerView];
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.3]];
    }
    return self;
}
- (void)show
{
    if (self.superview) {
        return;
    }
    [self setFrame:[UIScreen mainScreen].bounds];
    [_contentView setFrame:CGRectMake(0, self.zf_height, self.zf_width, self.zf_height * .375)];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    [UIView animateWithDuration:.3 animations:^{
        [_contentView setFrame:CGRectMake(0, self.zf_height * .625, self.zf_width, self.zf_height * .375)];
    }];
}
- (void)hide
{
    if (!self.superview) {
        return;
    }
    [UIView animateWithDuration:.3 animations:^{
        [_contentView setFrame:CGRectMake(0, self.zf_height, self.zf_width, self.zf_height * .375)];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (point.y < _contentView.zf_top) {
        [self hide];
    }
}
- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    if ([titles count] > 0) {
        NSString *string = _titles[0];
        if (!kStringIsEmpty(string)) {
            _text = string;
        }
    }
}
- (void)cancel:(UIButton *)btn
{
    [self hide];
}
- (void)ok:(UIButton *)btn
{
    if (_clickedOK) {
        _clickedOK(_text);
    }
    [self hide];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_cancelBtn setFrame:CGRectMake(15, 0, _contentView.zf_width * .5 - 15, 50)];
    [_okBtn setFrame:CGRectMake(_cancelBtn.zf_right, _cancelBtn.zf_top, _cancelBtn.zf_width, _cancelBtn.zf_height)];
    [_pickerView setFrame:CGRectMake(0, _cancelBtn.zf_bottom, _contentView.zf_width, _contentView.zf_height - _cancelBtn.zf_bottom)];
}
#pragma mark - pickerDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *string = _titles[row];
    if (!kStringIsEmpty(string)) {
        return string;
    }
    return nil;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return _contentView.zf_height * .2;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setMinimumScaleFactor:.8];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:18.f]];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *string = _titles[row];
    if (!kStringIsEmpty(string)) {
        _text = string;
    }
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_titles count];
}
@end
