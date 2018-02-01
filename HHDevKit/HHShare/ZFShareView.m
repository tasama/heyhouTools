//
//  ZFShareView.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 30/7/16.
//  Copyright © 2016年 肖泽峰. All rights reserved.
//

#import "ZFShareView.h"
#import "HHShareTypeBtn.h"
#import <UMSocialQQHandler.h>
#import <WXApi.h>
#import <HHUIKit/HHUIKit.h>

@interface ZFShareView ()

@property (nonatomic, strong) UIVisualEffectView *backGroundView;

@property (nonatomic , strong)UIScrollView *contentView;

@property (nonatomic , strong)NSMutableArray *shareBtns;

@property (nonatomic , strong)NSArray *images;

@property (nonatomic , strong)UIButton *cancel;

@property (nonatomic, strong) NSArray *btnTitles;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *line;

@end

@implementation ZFShareView

- (UIVisualEffectView *)backGroundView {
    
    if (!_backGroundView) {
        
        _backGroundView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        _backGroundView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _backGroundView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15.0f weight:UIFontWeightRegular];
        _titleLabel.text = @"分享至";
        _titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)line {
    
    if (!_line) {
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:.2f];
    }
    return _line;
}

- (UIScrollView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[UIScrollView alloc] init];
        [_contentView setShowsHorizontalScrollIndicator:NO];
        [_contentView setShowsVerticalScrollIndicator:NO];
        _contentView.scrollEnabled = NO;
    }
    return _contentView;
}

- (NSMutableArray *)shareBtns
{
    if (!_shareBtns)
    {
        _shareBtns = @[].mutableCopy;
    }
    return _shareBtns;
}

- (NSArray *)images
{
    if (!_images)
    {
        NSMutableArray *images = @[].mutableCopy;
        [images addObjectsFromArray:@[@"btn_weixin_",@"btn_moments_",@"btn_qq_", @"btn_space_",@"btn_weibo_"]];
        _images = images;
    }
    return _images;
}

- (NSArray *)btnTitles
{
    if (!_btnTitles)
    {
        NSMutableArray *images = @[].mutableCopy;
        [images addObjectsFromArray:@[@"微信好友",@"朋友圈",@"QQ", @"QQ空间",@"微博"]];
        _btnTitles = images;
    }
    return _btnTitles;
}

- (UIButton *)cancel
{
    if (!_cancel)
    {
//        _cancel = [[UIButton alloc] init];
//        [_cancel setBackgroundColor:[UIColor colorWithHexString:@"#ffffff" alpha:.85]];
//        [_cancel setTitle:@"取消" forState:UIControlStateNormal];
//        [_cancel setTitleColor:themeColor forState:UIControlStateNormal];
//        [_cancel.titleLabel setFont:[UIFont systemFontOfSize:18.f]];
//        [_cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancel;
}

- (void)loadUI
{
    [self addSubview:self.backGroundView];
    [self addSubview:self.contentView];
    /**
     fixed crash:2017-11-20
        Do not add subviews directly to UIVisualEffectView, use this view instead.
        xCode9 下编译，iOS11上运行会crash
     **/
    [self.backGroundView.contentView addSubview:self.titleLabel];
    [self.backGroundView.contentView addSubview:self.line];
    for (int i = 0; i < [self.images count]; i++)
    {
        HHShareTypeBtn *btn = [[HHShareTypeBtn alloc] init];
        [btn setImage:[UIImage imageNamed:self.images[i]] forState:UIControlStateNormal];
        [btn setTitle:self.btnTitles[i] forState:UIControlStateNormal];
        [btn setTitleColor:HH_COLOR_TEXT_SUB forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.tag = i;
        [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        [self.shareBtns addObject:btn];
    }
}

- (instancetype)initWithTarget:(id<ZFShareViewDelegate>)target
{
    if (self = [super init])
    {
        [self loadUI];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setDelegate:target];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (point.y < self.zf_height - 105)
    {
        [self hide];
    }
}

- (void)show
{
    if ([self.images count] == 0)
    {
        [HHAlert showAlertString:@"请先安装微信或者QQ"];
        return;
    }
    if (!self.superview)
    {
        [self setFrame:[UIScreen mainScreen].bounds];
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        [_backGroundView setFrame:CGRectMake(0, self.zf_height, self.zf_width, 180)];
        [_contentView setFrame:CGRectMake(0, self.zf_height, self.zf_width, 125)];
        [_cancel setFrame:CGRectMake(0, _contentView.zf_bottom, _contentView.zf_width, 45)];
        [UIView animateWithDuration:.3 animations:^{
            [_backGroundView setFrame:CGRectMake(0, self.zf_height - 170, self.zf_width, 180)];
            [_contentView setFrame:CGRectMake(0, self.zf_height - 170, self.zf_width, 125)];
            [_cancel setFrame:CGRectMake(0, _contentView.zf_bottom, _contentView.zf_width, 45)];
        }];
    }
}

- (void)hide
{
    if (self.superview)
    {
        [UIView animateWithDuration:.3 animations:^{
            [_backGroundView setFrame:CGRectMake(0, self.zf_height, self.zf_width, 180)];
            [_contentView setFrame:CGRectMake(0, self.zf_height, self.zf_width, 125)];
            [_cancel setFrame:CGRectMake(0, _contentView.zf_bottom, _contentView.zf_width, 45)];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.backGroundView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10.0f, 10.0f)];
//    
//    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
//    shapeLayer.path = path.CGPath;
//    shapeLayer.frame = self.backGroundView.bounds;
    
    self.backGroundView.layer.cornerRadius = 10.0f;
    self.backGroundView.layer.masksToBounds = YES;
    
    [_contentView setFrame:CGRectMake(0, self.zf_height - 170 + 45, self.zf_width, 125)];
    [_backGroundView setFrame:CGRectMake(0, self.zf_height - 170, self.zf_width, 180)];
    _titleLabel.frame = CGRectMake(0, 0, _contentView.zf_width, 45.0f);
    _line.frame = CGRectMake(0, _titleLabel.zf_bottom - 1.0f, _backGroundView.zf_width, 1.0f);
    for (int i = 0; i < [self.shareBtns count]; i++)
    {
        HHShareTypeBtn *btn = self.shareBtns[i];
        CGFloat margin = (self.zf_width - 50 * [self.shareBtns count]) / (([self.shareBtns count] + 1) * 1.0f);
        [btn setFrame:CGRectMake(margin + (50 + margin) * i, 25, 50, 75)];
        btn.layer.cornerRadius = btn.zf_height * .5;
        if (i == [self.shareBtns count] - 1)
        {
            [_contentView setContentSize:CGSizeMake(btn.zf_right + 30, 0)];
        }
    }
//    
//    [_cancel setFrame:CGRectMake(0, _contentView.zf_bottom, _contentView.zf_width, 45)];
}

- (void)onClick:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(shareView:didClickAtIndex:)])
    {
        [_delegate shareView:self didClickAtIndex:btn.tag];
        [self hide];
    }
}

- (void)cancel:(UIButton *)btn
{
    [self hide];
}


- (void)dealloc {
    
    NSLog(@"zfshare +++++ > dealloc");
}

@end
