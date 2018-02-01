//
//  HHWelcomeView.m
//  Heyhou
//
//  Created by XiaoZefeng on 9/10/16.
//  Copyright © 2016年 XiaoZefeng. All rights reserved.
//

#import "HHWelcomeView.h"
#import "HHUIConst.h"
#import "UIColor+Hex.h"
#import "UIView+Frame.h"
#import <HHLogSystem.h>
@interface HHWelcomeView ()<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *contentView;
@property (nonatomic, strong)NSMutableArray *imageViews;
@property (nonatomic, strong)UIButton *enter;
@property (nonatomic , strong)UIButton *loginBtn;
@property (nonatomic, strong)UIPageControl *pageControl;

@end

@implementation HHWelcomeView

- (UIScrollView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[UIScrollView alloc] init];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
        [_contentView setShowsVerticalScrollIndicator:NO];
        [_contentView setShowsHorizontalScrollIndicator:NO];
        [_contentView setPagingEnabled:YES];
        [_contentView setDelegate:self];
    }
    return _contentView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl)
    {
        _pageControl = [[UIPageControl alloc] init];
        [_pageControl setPageIndicatorTintColor:ThemeTextColor];
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
    }
    return _pageControl;
}

- (UIButton *)enter
{
    if (!_enter)
    {
        _enter = [[UIButton alloc] init];
        [_enter setTitle:@"进入" forState:UIControlStateNormal];
        _enter.layer.cornerRadius = 5;
        _enter.layer.borderWidth = .5;
        _enter.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:.6].CGColor;
        [_enter setTitleColor:[UIColor colorWithWhite:1.0 alpha:.6] forState:UIControlStateNormal];
        [_enter.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
        [_enter addTarget:self action:@selector(enter:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enter;
}
- (UIButton *)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] init];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.layer.cornerRadius = 5;
        _loginBtn.layer.borderWidth = .5;
        _loginBtn.layer.borderColor = themeColor.CGColor;
        [_loginBtn setTitleColor:themeColor forState:UIControlStateNormal];
        [_loginBtn.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
        [_loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _imageViews = @[].mutableCopy;
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)setImages:(NSArray *)images
{
    _images = images;
    
    [_imageViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_imageViews removeAllObjects];
    
    for (int i = 0; i < [images count]; i++)
    {
        
        NSString *imagePath = images[i];
        if ([imagePath isKindOfClass:[NSString class]])
        {
            UIImageView *imageView =[[UIImageView alloc] init];
            [imageView setUserInteractionEnabled:YES];
            [imageView setImage:IMAGE(imagePath)];
            [_imageViews addObject:imageView];
            [_contentView addSubview:imageView];
            if (i == ([images count] - 1) && self.enter.superview == nil)
            {
                [imageView addSubview:_enter];
            }
            if (i == ([images count] - 1) && self.loginBtn.superview == nil)
            {
                [imageView addSubview:_loginBtn];
            }
        }
    }
    if ([_imageViews count] > 1)
    {
        if (self.pageControl.superview == nil)
        {
            [self addSubview:self.pageControl];
        }
        [self.pageControl setNumberOfPages:_imageViews.count];
    }
}

- (void)enter:(UIButton *)btn
{
    if (_enterApp)
    {
        [UIView animateWithDuration:.5 animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        _enterApp(1);
    }
}

- (void)login:(UIButton *)btn
{
    if (_enterApp)
    {
        [UIView animateWithDuration:.5 animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        _enterApp(2);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / _contentView.zf_width;
    if (index != _pageControl.currentPage)
    {
        [_pageControl setCurrentPage:index];
    }
    if (index == [_images count] - 1) {
        [_pageControl setHidden:YES];
    }
    else
        [_pageControl setHidden:NO];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_contentView setFrame:self.bounds];
    for (int i = 0; i < [self.imageViews count]; i++)
    {
        UIImageView *imageView = self.imageViews[i];
        [imageView setFrame:_contentView.bounds];
        imageView.zf_left = i * _contentView.zf_width;
    }
    CGFloat width = SCREEN_WIDTH / 3;
    if (_enter.superview)
    {
        [_enter setFrame:CGRectMake(width / 3, SCREEN_HEIGHT * .86 , width, width * .32)];
        [_loginBtn setFrame:CGRectMake(_enter.zf_right + width / 3, _enter.zf_top, _enter.zf_width, _enter.zf_height)];
    }
    if (_pageControl.superview)
    {
        [_pageControl setFrame:CGRectMake(self.zf_width * .5 - 50, self.zf_height * .9, 100, 20)];
    }
    [_contentView setContentSize:CGSizeMake([_imageViews count] * self.zf_width, 0)];
}

- (void)dealloc
{
    HHLogDebug(@"welcomeView is dealloc");
}

@end
