

//
//  BannerView.m
//  CellCountDown
//
//  Created by XiaoZefeng on 5/7/16.
//  Copyright © 2016年 肖泽峰. All rights reserved.
//

#import "HHBannerView.h"
#import <UIImageView+WebCache.h>

#import "UIView+Frame.h"
#import "UIImageView+HHQiniuThumbnail.h"
#import "HHUIConst.h"

#import <HHFoundation/HHTimerProxy.h>
#import <HHFoundation/HHMarco.h>

@interface HHBannerView ()

@property (nonatomic, strong) NSArray *picArray;

@property (nonatomic, strong) NSMutableArray *imageViewArray;

@property (nonatomic , strong)UIImageView *leftImageView;

@property (nonatomic , strong)UIImageView *middleImageView;

@property (nonatomic , strong)UIImageView *rightImageView;

@property (nonatomic )BOOL remoteType;//是否远程图片

@property (nonatomic )NSInteger currentIndex;

@property (nonatomic , strong)NSTimer *timer;

@property (nonatomic , strong)HHTimerProxy *proxy;

@end

@implementation HHBannerView

{
    UIScrollView *scrollview;
}

- (NSMutableArray *)imageViewArray
{
    if (!_imageViewArray)
    {
        _imageViewArray = @[].mutableCopy;
        [_imageViewArray addObject:self.leftImageView];
        [_imageViewArray addObject:self.middleImageView];
        [_imageViewArray addObject:self.rightImageView];
    }
    return _imageViewArray;
}

- (UIImageView *)leftImageView
{
    if (!_leftImageView)
    {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.layer.masksToBounds = YES;
        _leftImageView.layer.cornerRadius = 5;
        [_leftImageView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_leftImageView addGestureRecognizer:tap];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _leftImageView;
}

- (UIImageView *)middleImageView
{
    if (!_middleImageView)
    {
        _middleImageView = [[UIImageView alloc] init];
        _middleImageView.layer.masksToBounds = YES;
        _middleImageView.layer.cornerRadius = 5;
        [_middleImageView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_middleImageView addGestureRecognizer:tap];
        _middleImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _middleImageView;
}

- (UIImageView *)rightImageView
{
    if (!_rightImageView)
    {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.layer.masksToBounds = YES;
        _rightImageView.layer.cornerRadius = 5;
        [_rightImageView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_rightImageView addGestureRecognizer:tap];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _rightImageView;
}

- (HHTimerProxy *)proxy
{
    if (!_proxy)
    {
        _proxy = [[HHTimerProxy alloc] initWithTarget:self];
    }
    return _proxy;
}

- (void)confirguePageControl
{
    [_pageControl removeFromSuperview];
    
    HHPageControl *page                = [[HHPageControl alloc] init];
    page.pageIndicatorTintColor        = [UIColor colorWithWhite:1.0 alpha:0.3];
    page.currentPageIndicatorTintColor = [UIColor whiteColor];
    //page.hidesForSinglePage            = YES;
    page.numberOfPages                 = [self.picArray count];
    page.currentPage                   = 0;
    
    [self addSubview:page];
    _pageControl = page;
}

- (void)confirgueScrollView
{
    scrollview = [[UIScrollView alloc] init];
    scrollview.pagingEnabled = YES;
    scrollview.clipsToBounds = NO;
    [scrollview setShowsVerticalScrollIndicator:NO];
    [scrollview setShowsHorizontalScrollIndicator:NO];
    scrollview.delegate = self;
    [self addSubview:scrollview];
    
    [scrollview addSubview:self.leftImageView];
    [scrollview addSubview:self.middleImageView];
    [scrollview addSubview:self.rightImageView];
}

- (instancetype)initWithTarget:(id <UIScrollViewDelegate, BannerViewDelegate>)target
{
    self = [super init];
    
    if (self)
    {
        _zoomEnable = YES;
        _fullScreenEnable = NO;
        [self confirgueScrollView];
        [self confirguePageControl];
        self.clipsToBounds = YES;
        // 添加代理
        scrollview.delegate = target;
        _delegate = target;
        _currentIndex = 1;
        _remoteType = NO;
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self.proxy selector:@selector(autoScroll:) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)setFullScreenEnable:(BOOL)fullScreenEnable
{
    _fullScreenEnable = fullScreenEnable;
    if (fullScreenEnable) {
        self.leftImageView.layer.cornerRadius = 0;
        self.middleImageView.layer.cornerRadius = 0;
        self.rightImageView.layer.cornerRadius = 0;
    }
    else
    {
        self.leftImageView.layer.cornerRadius = 5;
        self.middleImageView.layer.cornerRadius = 5;
        self.rightImageView.layer.cornerRadius = 5;
    }
}

- (void)autoScroll:(NSTimer *)timer
{
    [scrollview setContentOffset:CGPointMake(scrollview.contentOffset.x + scrollview.zf_width, 0) animated:YES];

    BOOL checkRes = [self checkOffsetX];
    if (!checkRes) {
        [scrollview setContentOffset:CGPointMake(scrollview.zf_width, 0) animated:YES];
    }
}

- (BOOL)checkOffsetX {
    BOOL checkRes = NO;
    for (int i = 0; i < 3; i++) {
        checkRes = (scrollview.contentOffset.x == scrollview.zf_width * i);
        if (checkRes) break;
    }
    return checkRes;
}

- (void)setDataSource:(id)dataSource
{
    if ([dataSource isKindOfClass:[NSArray class]]) {
        _dataSource = dataSource;
        NSMutableArray *imageUrl = @[].mutableCopy;
        for (id dic in dataSource) {
            if ([dic isKindOfClass:[NSDictionary class]]) {
                id url = dic[@"fileKey"];
                if (!kObjectIsEmpty(url)) {
                    [imageUrl addObject:url];
                }
            }
        }
        [self loadImagesWithUrl:imageUrl];
    }
}

// 加载本地图片
- (void)loadImages:(NSArray *)array
{
    
    if ([array count] == 0 || !array)
    {
        return;
    }
    
    _picArray = array;
    
    for (int i = 0; i < MIN(3, [array count]); i++)
    {
        UIImage * image = [UIImage imageNamed:array[i]];
        if (!image) {
            image = PlaceholderImage;
        }
        UIImageView * iv = self.imageViewArray[i];
        [iv setImage:image];
    }
    
    _currentIndex = 0;
    
    self.pageControl.numberOfPages                 = [self.picArray count];
    if (self.picArray.count == 1) {
        self.pageControl.hidden = YES;
        [self.timer setFireDate:[NSDate distantFuture]];
    } else {
        self.pageControl.hidden = NO;
        [self.timer setFireDate:[NSDate distantPast]];
    }
 
    [self changeImageLeft:[self.picArray count] - 1 middle:0 right:1];
}


// 加载网络图片
- (void)loadImagesWithUrl:(NSArray *)array
{
    
    if ([array count] == 0 || !array)
    {
        return;
    }
    
    _picArray = array;
    
    _remoteType = YES;
    
    for (int i = 0; i < MIN(3, [array count]); i++)
    {
        UIImageView *iv = self.imageViewArray[i];
      //  NSString *imageUrl = [array[i] stringByAppendingString:QiNiuPhotoThumbnailMaxSize];
        [iv hh_setImageWithURL:[NSURL URLWithString:array[i]] placeholderImage:PlaceholderImage];
    }
    
    _currentIndex = 0;
    
    self.pageControl.numberOfPages                 = [self.picArray count];
    if (self.picArray.count == 1) {
        self.pageControl.hidden = YES;
        [self.timer setFireDate:[NSDate distantFuture]];
    } else {
        self.pageControl.hidden = NO;
        [self.timer setFireDate:[NSDate distantPast]];
    }
    [self changeImageLeft:[self.picArray count] - 1 middle:0 right:1];
}

- (void)changeImageLeft:(NSInteger)leftIndex middle:(NSInteger)middleIndex right:(NSInteger)rightIndex
{
    if ([self.picArray count] == 1)
    {
        leftIndex = middleIndex = rightIndex = 0;
    }
    if (_remoteType)
    {
        [_leftImageView hh_setImageWithURL:[NSURL URLWithString:self.picArray[leftIndex]] placeholderImage:PlaceholderImage];
        [_middleImageView hh_setImageWithURL:[NSURL URLWithString:self.picArray[middleIndex]] placeholderImage:PlaceholderImage];
        [_rightImageView hh_setImageWithURL:[NSURL URLWithString:self.picArray[rightIndex]] placeholderImage:PlaceholderImage];
    }
    else
    {
        [_leftImageView setImage:[UIImage imageNamed:self.picArray[leftIndex]]];
        [_middleImageView setImage:[UIImage imageNamed:self.picArray[middleIndex]]];
        [_rightImageView setImage:[UIImage imageNamed:self.picArray[rightIndex]]];
    }
    
    if (_zoomEnable)
    {
        [scrollview setContentOffset:CGPointMake(scrollview.zf_width, 0)];
    }
    else
    {
        [scrollview setContentOffset:CGPointMake(scrollview.zf_width, 0)];
    }
}

// 滚动时改变大小

- (void)scroll
{
    CGFloat offsetX = scrollview.contentOffset.x;
    
    [self scrollToOffsetX:offsetX];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollview.contentOffset.x;
    
    [self scrollToOffsetX:offsetX];
}

- (void)scrollToOffsetX:(CGFloat )offsetX
{
    if (_zoomEnable)
    {
        for (int i = 0; i < MIN(3, [self.picArray count]); i++)
        {
            UIImageView *iv = self.imageViewArray[i];
            CGRect bounds = iv.bounds;
            bounds.size.width = scrollview.zf_width * (.8 + .2 * (scrollview.zf_width - fabs(scrollview.contentOffset.x - scrollview.zf_width * i)) / scrollview.zf_width);
            bounds.size.height = scrollview.zf_height * (.8 + .2 * (scrollview.zf_width - fabs(scrollview.contentOffset.x - scrollview.zf_width * i)) / scrollview.zf_width);
            [iv setBounds:bounds];
        }
    }
    
    if (offsetX >= scrollview.zf_width * 2)
    {
        _currentIndex++;
        
        if (_currentIndex == [self.picArray count] - 1)
        {
            [self changeImageLeft:_currentIndex - 1 middle:_currentIndex right:0];
        }
        else if (_currentIndex == [self.picArray count])
        {
            _currentIndex = 0;
            [self changeImageLeft:[self.picArray count] - 1 middle:0 right:1];
        }
        else
        {
            [self changeImageLeft:_currentIndex - 1 middle:_currentIndex right:_currentIndex + 1];
        }
    }
    
    if (offsetX <= 0)
    {
        _currentIndex--;
        
        if (_currentIndex == 0)
        {
            [self changeImageLeft:[self.picArray count] - 1 middle:0 right:1];
        }
        else if(_currentIndex == - 1)
        {
            _currentIndex = [self.picArray count] - 1;
            [self changeImageLeft:_currentIndex - 1 middle:_currentIndex right:0];
        }
        else
        {
            [self changeImageLeft:_currentIndex - 1 middle:_currentIndex right:_currentIndex + 1];
        }
    }
    
    [_pageControl setCurrentPage:_currentIndex];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (!_fullScreenEnable)
    {
        [scrollview setFrame:CGRectMake(self.zf_width / 6, 20, self.zf_width * 2 / 3 + 20, self.zf_height - 42)];
        
        for (int i = 0; i < 3; i++)
        {
            UIImageView *iv = self.imageViewArray[i];
            [iv setFrame:CGRectMake(scrollview.zf_width * i, 0, scrollview.zf_width - 20, scrollview.zf_height)];
        }
        scrollview.contentSize = CGSizeMake(3 * (scrollview.zf_width + 20), 0);
        [scrollview setContentOffset:CGPointMake(scrollview.zf_width, 0)];
        [_pageControl setFrame:CGRectMake(0, 0, self.zf_width, 6)];
        [_pageControl setCenter:CGPointMake(self.zf_width * .5, self.zf_height - 13)];
    }
    else
    {
        [scrollview setFrame:CGRectMake(0, 0, self.zf_width, self.zf_height)];//* 2 / 3
        
        for (int i = 0; i < 3; i++)
        {
            UIImageView *iv = self.imageViewArray[i];
            [iv setFrame:CGRectMake(scrollview.zf_width * i, 0, scrollview.zf_width , scrollview.zf_height)];
        }
        scrollview.contentSize = CGSizeMake(3 * scrollview.zf_width, 0);
        [scrollview setContentOffset:CGPointMake(scrollview.zf_width, 0)];
        [_pageControl setFrame:CGRectMake(0, 0, self.zf_width, 6)];
        [_pageControl setCenter:CGPointMake(self.zf_width * .5, self.zf_height - 13)];
    }
    
}

- (void)dealloc
{
    scrollview.delegate = nil;
    _delegate = nil;
    [self.timer invalidate];
    _timer = nil;
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    if ([_delegate respondsToSelector:@selector(bannerView:didSelectAtIndex:)])
    {
        [_delegate bannerView:self didSelectAtIndex:_currentIndex];
    }
}

@end
