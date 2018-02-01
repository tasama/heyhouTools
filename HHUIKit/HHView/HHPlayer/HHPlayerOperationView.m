//
//  HHPlayerOperationView.m
//  ZFPlayer_Demo
//
//  Created by XiaoZefeng on 10/7/17.
//  Copyright © 2017年 HH_XiaoZefeng. All rights reserved.
//

#import "HHPlayerOperationView.h"
#import "HHNextRunlooperRunner.h"
#import "UIView+Frame.h"
#import "UIColor+Hex.h"
#import "HHUIConst.h"

@interface HHPlayerOperationView ()<UIGestureRecognizerDelegate>

@property (nonatomic, readwrite) BOOL lockEnable;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) CAGradientLayer *headerGradientLayer;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic, strong) UIButton *playBigButton;

@property (nonatomic, strong) UIButton *lockButton;

@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) CAGradientLayer *footerGradientLayer;

@property (nonatomic, strong) UIButton *playSmallButton;

@property (nonatomic, strong) UILabel *currentTimeLabel;

@property (nonatomic, strong) UILabel *allTimeLabel;

@property (nonatomic, strong) UIButton *fullScreenButton;

@property (nonatomic, strong) UISlider *progressSlider;

///< full screen buttons

@property (nonatomic, strong) UIButton *collectButton;


@property (nonatomic, strong) UIButton *likeButton;

//@property (nonatomic, strong) UIButton *downloadButton;

@property (nonatomic, strong) UIButton *giftButton;

@property (nonatomic) BOOL subviewsHidden;

@property (nonatomic, assign) HHPanDirection           panDirection;

@end

@implementation HHPlayerOperationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupSmallScreenSubviews];
        [self addGestures];
        [self hideAllSubviews];
        //[self performSelector:@selector(hideAllSubviews) withObject:nil afterDelay:5.f];
    }
    return self;
}

- (void)addGestures
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
    
    // 添加平移手势，用来控制音量、亮度、快进快退
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panDirection:)];
    panRecognizer.delegate = self;
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelaysTouchesBegan:YES];
    [panRecognizer setDelaysTouchesEnded:YES];
    [panRecognizer setCancelsTouchesInView:YES];
    [self addGestureRecognizer:panRecognizer];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {

    if ([touch.view isKindOfClass:[UISlider class]]) {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)layoutSubviews
{
    CGSize imageSize;
    CGFloat statusBarHeight = 20;
    CGFloat navigationBarHeight = 44;
    if (self.fullScreenButton.selected) {// full screen mode
        
        CGFloat headerHeight = 50;
        self.headerView.frame = CGRectMake(0, 0, self.zf_width, headerHeight);
        self.headerGradientLayer.frame = self.headerView.bounds;
        imageSize = self.backButton.imageView.image.size;
        self.backButton.frame = CGRectMake(0, 0, imageSize.width + 32, headerHeight);
        imageSize = self.moreButton.imageView.image.size;
        self.moreButton.frame = CGRectMake(self.zf_width - imageSize.width - 40, self.backButton.zf_top, imageSize.width + 40, self.backButton.zf_height);
        imageSize = self.lockButton.imageView.image.size;
        self.titleLabel.zf_size = CGSizeMake(self.headerView.zf_width - MAX(self.backButton.zf_width, self.moreButton.zf_width) * 2, headerHeight);
        self.titleLabel.center = CGPointMake(self.headerView.zf_width * .5, self.headerView.zf_height * .5);
        self.lockButton.zf_size = imageSize;
        self.lockButton.center = CGPointMake(self.zf_width - 15 - imageSize.width * .5, self.zf_height * .5);
        
        CGFloat bottomHeight = 70;
        self.footerView.frame = CGRectMake(0, self.zf_height - bottomHeight, self.zf_width, bottomHeight);
        self.footerGradientLayer.frame = self.footerView.bounds;
        CGFloat labelWidth = 30;///< 计算00:00的宽度
        CGFloat bottomContentHeight = 34;//11 + 11 + font of size
        self.currentTimeLabel.frame = CGRectMake(5, bottomHeight - bottomContentHeight, labelWidth + 20, bottomContentHeight);
        {
            imageSize = self.giftButton.imageView.image.size;
            self.giftButton.frame = CGRectMake(self.footerView.zf_width - 5 - imageSize.width - 20, self.currentTimeLabel.zf_top, imageSize.width + 20, bottomContentHeight);
//            self.downloadButton.frame = CGRectMake(self.giftButton.zf_left - self.giftButton.zf_width, self.giftButton.zf_top, self.giftButton.zf_width, bottomContentHeight);
            self.likeButton.frame = CGRectMake(self.giftButton.zf_left - self.giftButton.zf_width, self.giftButton.zf_top, self.giftButton.zf_width, bottomContentHeight);
            self.shareButton.frame = CGRectMake(self.likeButton.zf_left - self.likeButton.zf_width, self.likeButton.zf_top, self.likeButton.zf_width, bottomContentHeight);
            self.collectButton.frame = CGRectMake(self.shareButton.zf_left - self.shareButton.zf_width, self.shareButton.zf_top, self.shareButton.zf_width, bottomContentHeight);
        }
        self.allTimeLabel.frame = CGRectMake(self.collectButton.zf_left - 20 - labelWidth, self.currentTimeLabel.zf_top, self.currentTimeLabel.zf_width, self.currentTimeLabel.zf_height);
        self.progressSlider.frame = CGRectMake(self.currentTimeLabel.zf_right, self.currentTimeLabel.zf_top, self.allTimeLabel.zf_left - 5 - self.currentTimeLabel.zf_right, bottomContentHeight);
    } else {// not full screen mode
        imageSize = self.backButton.imageView.image.size;
        self.backButton.frame = CGRectMake(0, statusBarHeight, imageSize.width + 20, navigationBarHeight);
        imageSize = self.moreButton.imageView.image.size;
        self.moreButton.frame = CGRectMake(self.zf_width - imageSize.width - 20, self.backButton.zf_top, imageSize.width + 20, self.backButton.zf_height);
        
        CGFloat bottomHeight = 23;///< 14 + font.size
        self.footerView.frame = CGRectMake(0, self.zf_height - bottomHeight, self.zf_width, bottomHeight);
        self.footerGradientLayer.frame = self.footerView.bounds;
        imageSize = self.playSmallButton.imageView.image.size;
        self.playSmallButton.frame = CGRectMake(5, 0, imageSize.width + 10, bottomHeight);
        CGFloat labelWidth = 30;///< 计算00:00的宽度
        self.currentTimeLabel.frame = CGRectMake(self.playSmallButton.zf_right + 5, self.playSmallButton.zf_top, labelWidth, bottomHeight);
        self.allTimeLabel.frame = CGRectMake(self.footerView.zf_width - 10 - labelWidth, self.currentTimeLabel.zf_top, labelWidth, bottomHeight);
        self.progressSlider.frame = CGRectMake(self.currentTimeLabel.zf_right + 5, 0, self.allTimeLabel.zf_left - 10 - self.currentTimeLabel.zf_right, bottomHeight);
        
        imageSize = self.fullScreenButton.imageView.image.size;
        self.fullScreenButton.frame = CGRectMake(self.zf_width - 15 - imageSize.width, self.footerView.zf_top - 3 - imageSize.height, imageSize.width + 6, imageSize.height + 6);
    }
    
    imageSize = self.playBigButton.imageView.image.size;
    self.playBigButton.zf_size = CGSizeMake(imageSize.width + 10, imageSize.height + 10);
    self.playBigButton.center = CGPointMake(self.zf_width * .5, self.zf_height * .5);
}

#pragma mark - Public Methods

- (void)showAllSubviews
{
    self.subviewsHidden = NO;
    
    if (self.lockButton.selected) {
        [UIView animateWithDuration:.1f animations:^{
            self.lockButton.alpha = 1.f;
        } completion:^(BOOL finished) {
            self.lockButton.hidden = NO;
        }];
    } else {

        [UIView animateWithDuration:.1f animations:^{
            
            if ([self.allTime isEqualToString:@"00:00"] || !self.allTime  || self.loading) {
                
//                [self.playBigButton setAlpha:1.0f];
            } else {
                
                for (UIView *subview in self.subviews) {
                    
                    [subview setAlpha:1.f];
                    if (subview == self.headerView) {
                        
                        for (UIView *headSub in self.headerView.subviews) {
                            headSub.alpha = 1.f;
                        }
                    } else if (self.footerView == subview) {
                        for (UIView *footerSub in self.footerView.subviews) {
                            footerSub.alpha = 1.f;
                        }
                    }
                }
            }
        } completion:^(BOOL finished) {
            
            if ([self.allTime isEqualToString:@"00:00"] || !self.allTime  || self.loading) {
                
//                [self.playBigButton setHidden:self.subviewsHidden];
            } else {
                
                for (UIView *subview in self.subviews) {
                    
                    [subview setHidden:self.subviewsHidden];
                    
                    if (subview == self.headerView) {
                        
                        for (UIView *headSub in self.headerView.subviews) {
                            headSub.hidden = self.subviewsHidden;
                        }
                    } else if (self.footerView == subview) {
                        for (UIView *footerSub in self.footerView.subviews) {
                            footerSub.hidden = self.subviewsHidden;
                        }
                    }
                }
            }
        }];
    }

    [self performSelector:@selector(hideAllSubviews) withObject:nil afterDelay:5.f];
}

- (void)hideAllSubviews
{
    self.subviewsHidden = YES;
    
    if (self.lockButton.selected) {
        [UIView animateWithDuration:.1f animations:^{
            self.lockButton.alpha = 0.f;
        } completion:^(BOOL finished) {
            self.lockButton.hidden = YES;
        }];
    } else {
        [UIView animateWithDuration:.1f animations:^{
            for (UIView *subview in self.subviews) {
                
                if (subview == self.headerView) {
                    for (UIView *headSub in self.headerView.subviews) {
                        if (headSub != self.backButton) {
                    
                            headSub.alpha = 0.f;
                        }
                    }
                } else if (self.footerView == subview) {
                    for (UIView *footerSub in self.footerView.subviews) {
                        footerSub.alpha = 0.f;
                    }
                } else {
                    
                    [subview setAlpha:0.f];
                }
            }
        } completion:^(BOOL finished) {
            for (UIView *subview in self.subviews) {
                
                if (subview == self.headerView) {
                    for (UIView *headSub in self.headerView.subviews) {
                        if (headSub != self.backButton) {
                            
                            headSub.hidden = self.subviewsHidden;
                        }
                    }
                } else if (self.footerView == subview) {
                    for (UIView *footerSub in self.footerView.subviews) {
                        footerSub.hidden = self.subviewsHidden;
                    }
                } else {
                    [subview setHidden:self.subviewsHidden];
                }
            }
        }];
    }
}

- (void)hidePlayBtn {
    
    self.playBigButton.hidden = YES;
}

- (void)resetSubviewsState
{
    self.playBigButton.selected = NO;
    self.playSmallButton.selected = NO;
    self.progressSlider.value = 0;
    self.currentTime = @"00:00";
    self.allTime = @"00:00";
    [self cutFullScreenMode:NO];
}

- (void)play
{
//    [self tapAction];
    self.playSmallButton.selected = YES;
    self.playBigButton.selected = YES;
}

- (void)setLikeEnable:(BOOL)isFav
{
    self.likeButton.selected = isFav;
}

- (void)setCollectEnable:(BOOL)enable
{
    self.collectButton.selected = enable;
}

#pragma mark - Private Methods

- (void)setupSmallScreenSubviews
{
    //[self addSubview:self.backButton];
    [self addSubview:self.moreButton];
    [self addSubview:self.playBigButton];
    [self addSubview:self.footerView];
    [self.footerView.layer addSublayer:self.footerGradientLayer];
    [self.footerView addSubview:self.progressSlider];
    [self.footerView addSubview:self.playSmallButton];
    [self.footerView addSubview:self.currentTimeLabel];
    [self.footerView addSubview:self.allTimeLabel];
    [self addSubview:self.fullScreenButton];
    
    self.currentTimeLabel.font = [UIFont systemFontOfSize:9.f];
    self.allTimeLabel.font = [UIFont systemFontOfSize:9.f];
}

- (void)setupFullScreenSubviews
{
    [self addSubview:self.headerView];
    [self.headerView.layer addSublayer:self.headerGradientLayer];
    [self.headerView addSubview:self.backButton];
    [self.headerView addSubview:self.titleLabel];
    [self.headerView addSubview:self.moreButton];
    
    [self addSubview:self.playBigButton];
    [self addSubview:self.lockButton];
    
    [self addSubview:self.footerView];
    [self.footerView.layer addSublayer:self.footerGradientLayer];
    [self.footerView addSubview:self.currentTimeLabel];
    [self.footerView addSubview:self.allTimeLabel];
    [self.footerView addSubview:self.progressSlider];
    [self.footerView addSubview:self.shareButton];
//    [self.footerView addSubview:self.downloadButton];
    [self.footerView addSubview:self.likeButton];
    [self.footerView addSubview:self.collectButton];
    [self.footerView addSubview:self.giftButton];
    
    self.currentTimeLabel.font = [UIFont systemFontOfSize:12.f];
    self.allTimeLabel.font = [UIFont systemFontOfSize:12.f];
}

- (void)cutFullScreenMode:(BOOL)fullScreen
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.headerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.headerGradientLayer removeFromSuperlayer];
    [self.footerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.footerGradientLayer removeFromSuperlayer];
    
    if (fullScreen) {
        [self setupFullScreenSubviews];
    } else {
        [self setupSmallScreenSubviews];
    }
    [self setNeedsLayout];
}

#pragma mark - Setters 

- (void)setCurrentTime:(NSString *)currentTime
{
    _currentTime = [currentTime copy];
    self.currentTimeLabel.text = currentTime;
}

- (void)setAllTime:(NSString *)allTime
{
    _allTime = allTime;
    self.allTimeLabel.text = allTime;
}

- (void)setSlideValue:(float)slideValue
{
    _slideValue = slideValue;
    self.progressSlider.value = slideValue;
}

- (void)setFullScrren:(BOOL)fullScrren
{
    if (fullScrren == _fullScrren) {
        return;
    }
    _fullScrren = fullScrren;
    self.fullScreenButton.selected = fullScrren;
    [self cutFullScreenMode:fullScrren];
}

- (void)setMediaTitle:(NSString *)mediaTitle
{
    _mediaTitle = [mediaTitle copy];
    ///< set media's title
    self.titleLabel.text = _mediaTitle;
}

- (void)setLoading:(BOOL)loading {
    
    _loading = loading;
}

#pragma mark - Action Methods

- (void)clickedBack:(UIButton *)btn
{
    [self tapAction];
    
    if (self.fullScreenButton.selected) {
        self.fullScreenButton.selected = NO;
        if ([_delegate respondsToSelector:@selector(operationView:clickedFullScreenButton:)]) {
            [_delegate operationView:self clickedFullScreenButton:self.fullScreenButton];
        }
        return;
    }
    
    if ([_delegate respondsToSelector:@selector(operationView:clickedBackButton:)]) {
        [_delegate operationView:self clickedBackButton:btn];
    }
}

- (void)clickedMore:(UIButton *)btn
{
    [self tapAction];
    if ([_delegate respondsToSelector:@selector(operationView:clickedMoreButton:)]) {
        [_delegate operationView:self clickedMoreButton:btn];
    }
}

- (void)clickedPlay:(UIButton *)btn
{
    [self tapAction];
    self.playSmallButton.selected = !self.playSmallButton.selected;
    self.playBigButton.selected = !self.playBigButton.selected;
    if ([_delegate respondsToSelector:@selector(operationView:clickedPlayButton:)]) {
        [_delegate operationView:self clickedPlayButton:btn];
    }
}

- (void)clickedLock:(UIButton *)btn
{
    [self tapAction];
    btn.selected = !btn.selected;
    self.lockEnable = btn.selected;
    if (btn.selected) {
        [self hideAllSubviews];
        [HHNextRunlooperRunner runBlock:^{
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [NSThread sleepForTimeInterval:.105f];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.lockButton.alpha = 1.f;
                    self.lockButton.hidden = NO;
                    [self performSelector:@selector(hideAllSubviews) withObject:nil afterDelay:5.f];
                });
            });
        }];
    } else {
        [self showAllSubviews];
    }
}

- (void)clickedFullScreen:(UIButton *)btn
{
    [self tapAction];
    btn.selected = !btn.selected;
    if ([_delegate respondsToSelector:@selector(operationView:clickedFullScreenButton:)]) {
        [_delegate operationView:self clickedFullScreenButton:btn];
    }
}

- (void)clickedCollect:(UIButton *)btn
{
    [self tapAction];
    if ([_delegate respondsToSelector:@selector(operationView:clickedCollectButton:)]) {
        [_delegate operationView:self clickedCollectButton:btn];
    }
}

- (void)clickedShare:(UIButton *)btn
{
    [self tapAction];
    if ([_delegate respondsToSelector:@selector(operationView:clickedShareButton:)]) {
        [_delegate operationView:self clickedShareButton:btn];
    }
}

- (void)clickedLike:(UIButton *)btn
{
    [self tapAction];
    if ([_delegate respondsToSelector:@selector(operationView:clickedLikeButton:)]) {
        [_delegate operationView:self clickedLikeButton:btn];
    }
}

//- (void)clickedDownload:(UIButton *)btn
//{
//    [self tapAction];
//    if ([_delegate respondsToSelector:@selector(operationView:clickedDownloadButton:)]) {
//        [_delegate operationView:self clickedDownloadButton:btn];
//    }
//}

- (void)clickedGift:(UIButton *)btn
{
    [self tapAction];
    if ([_delegate respondsToSelector:@selector(operationView:clickedGiftButton:)]) {
        [_delegate operationView:self clickedGiftButton:btn];
    }
}

- (void)tapAction
{
    if (self.loading) {
        
        return;
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideAllSubviews) object:nil];
    [self showAllSubviews];
}

- (void)panDirection:(UIPanGestureRecognizer *)pan
{
    //根据在view上Pan的位置，确定是调音量还是亮度
    CGPoint locationPoint = [pan locationInView:self];
    
    if (locationPoint.y > self.footerView.zf_top) {
        return;
    }
    
    // 我们要响应水平移动和垂直移动
    // 根据上次和本次移动的位置，算出一个速率的point
    CGPoint veloctyPoint = [pan velocityInView:self];
    // 判断是垂直移动还是水平移动
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: { // 开始移动
            // 使用绝对值来判断移动的方向
            CGFloat x = fabs(veloctyPoint.x);
            CGFloat y = fabs(veloctyPoint.y);
            self.panDirection = (x > y) ? HHPanDirectionHorizontalMoved : HHPanDirectionVerticalMoved;
            if ([_delegate respondsToSelector:@selector(operationView:beginMoved:atPoint:)]) {
                [_delegate operationView:self beginMoved:self.panDirection atPoint:locationPoint];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{ // 正在移动
            [self tapAction];
            if ([_delegate respondsToSelector:@selector(operationView:changeMoved:atPoint:)]) {
                [_delegate operationView:self changeMoved:self.panDirection atPoint:veloctyPoint];
            }
        }
            break;
        case UIGestureRecognizerStateEnded:{ // 移动停止
            if ([_delegate respondsToSelector:@selector(operationView:endMoved:atPoint:)]) {
                [_delegate operationView:self endMoved:self.panDirection atPoint:veloctyPoint];
            }
        }
            break;
        default:
            break;
    }
}

- (void)tapSliderAction:(UITapGestureRecognizer *)tap
{
    if ([tap.view isKindOfClass:[UISlider class]]) {
        UISlider *slider = (UISlider *)tap.view;
        CGPoint point = [tap locationInView:slider];
        CGFloat length = slider.frame.size.width;
        // 视频跳转的value
        CGFloat tapValue = point.x / length;
        self.progressSlider.value = tapValue;
        [self hidePlayBtn];
        self.loading = YES;
        if ([_delegate respondsToSelector:@selector(operationView:tapProgressSlider:)]) {
            [_delegate operationView:self tapProgressSlider:self.progressSlider];
        }
    }
}
// 不做处理，只是为了滑动slider其他地方不响应其他手势
- (void)panRecognizer:(UIPanGestureRecognizer *)sender {}

#pragma mark - Lazy Loads

- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.backgroundColor = [UIColor clearColor];
    }
    return _headerView;
}

- (CAGradientLayer *)headerGradientLayer
{
    if (!_headerGradientLayer) {
        _headerGradientLayer = [CAGradientLayer layer];
        _headerGradientLayer.colors = @[(__bridge id)[UIColor colorWithWhite:0.f alpha:.7f].CGColor,
                                        (__bridge id)[UIColor clearColor].CGColor
                                        ];
        _headerGradientLayer.startPoint = CGPointMake(0, 0);
        _headerGradientLayer.endPoint = CGPointMake(0, 1.0);
    }
    return _headerGradientLayer;
}

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton new];
        [_backButton setImage:[UIImage imageNamed:@"public_back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(clickedBack:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:17.f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)moreButton
{
    if (!_moreButton) {
        _moreButton = [UIButton new];
        [_moreButton setImage:[UIImage imageNamed:@"public_more"] forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(clickedMore:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

- (UIButton *)playBigButton
{
    if (!_playBigButton) {
        _playBigButton = [UIButton new];
        [_playBigButton setImage:[UIImage imageNamed:@"VideoPlayer_player_round"] forState:UIControlStateNormal];
        [_playBigButton setImage:[UIImage imageNamed:@"videoPlayer_pause"] forState:UIControlStateSelected];
        [_playBigButton addTarget:self action:@selector(clickedPlay:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBigButton;
}

- (UIButton *)lockButton
{
    if (!_lockButton) {
        _lockButton = [UIButton new];
        [_lockButton setImage:[UIImage imageNamed:@"shipin_kaisuo"] forState:UIControlStateNormal];
        [_lockButton setImage:[UIImage imageNamed:@"VideoPlayer_lock"] forState:UIControlStateSelected];
        [_lockButton addTarget:self action:@selector(clickedLock:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lockButton;
}

- (UIView *)footerView
{
    if (!_footerView) {
        _footerView = [UIView new];
        _footerView.backgroundColor = [UIColor clearColor];
    }
    return _footerView;
}

- (CAGradientLayer *)footerGradientLayer
{
    if (!_footerGradientLayer) {
         _footerGradientLayer = [CAGradientLayer layer];
         _footerGradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                  (__bridge id)[UIColor colorWithWhite:0.f alpha:.7f].CGColor
                                  ];
         _footerGradientLayer.startPoint = CGPointMake(0, 0);
         _footerGradientLayer.endPoint = CGPointMake(0, 1.0);
    }
    return _footerGradientLayer;
}

- (UIButton *)playSmallButton
{
    if (!_playSmallButton) {
        _playSmallButton = [UIButton new];
        [_playSmallButton setImage:[UIImage imageNamed:@"VideoPlayer_play_small"] forState:UIControlStateNormal];
        [_playSmallButton setImage:[UIImage imageNamed:@"VideoPlayer_pause01"] forState:UIControlStateSelected];
        [_playSmallButton addTarget:self action:@selector(clickedPlay:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playSmallButton;
}

- (UILabel *)currentTimeLabel
{
    if (!_currentTimeLabel) {
        _currentTimeLabel = [UILabel new];
        _currentTimeLabel.textColor = [UIColor whiteColor];
        _currentTimeLabel.font = [UIFont systemFontOfSize:9.f];
        _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
        _currentTimeLabel.text = @"00:00";
    }
    return _currentTimeLabel;
}

- (UILabel *)allTimeLabel
{
    if (!_allTimeLabel) {
        _allTimeLabel = [UILabel new];
        _allTimeLabel.textColor = [UIColor whiteColor];
        _allTimeLabel.font = [UIFont systemFontOfSize:9.f];
        _allTimeLabel.textAlignment = NSTextAlignmentCenter;
        _allTimeLabel.text = @"00:00";
    }
    return _allTimeLabel;
}

- (UIButton *)fullScreenButton
{
    if (!_fullScreenButton) {
        _fullScreenButton = [UIButton new];
        [_fullScreenButton setImage:[UIImage imageNamed:@"VideoPlayer_fullScreen"] forState:UIControlStateNormal];
        [_fullScreenButton setImage:[UIImage imageNamed:@"VideoPlayer_smallScreen"] forState:UIControlStateSelected];
        [_fullScreenButton addTarget:self action:@selector(clickedFullScreen:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullScreenButton;
}

- (UISlider *)progressSlider
{
    if (!_progressSlider) {
        _progressSlider = [UISlider new];
        _progressSlider.maximumValue = 1;
        _progressSlider.minimumValue = 0;
        _progressSlider.minimumTrackTintColor = HH_COLOR_RED;
        _progressSlider.maximumTrackTintColor = [UIColor colorWithHexString:@"#D8D8D8"];
        _progressSlider.continuous = NO;// 设置为不可连续变化
        [_progressSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];// 针对值变化添加响应方法
        [_progressSlider setThumbImage:[UIImage imageNamed:@"public_dot"] forState:UIControlStateNormal];
        
        UITapGestureRecognizer *sliderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSliderAction:)];
        [_progressSlider addGestureRecognizer:sliderTap];
//
//        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panRecognizer:)];
//        panRecognizer.delegate = self;
//        [panRecognizer setMaximumNumberOfTouches:1];
//        [panRecognizer setDelaysTouchesBegan:YES];
//        [panRecognizer setDelaysTouchesEnded:YES];
//        [panRecognizer setCancelsTouchesInView:YES];
//        [_progressSlider addGestureRecognizer:panRecognizer];
    }
    return _progressSlider;
}

- (void)sliderValueChanged:(id)sender {
    
    [self hidePlayBtn];
    if ([_delegate respondsToSelector:@selector(operationView:tapProgressSlider:)]) {
        [_delegate operationView:self tapProgressSlider:self.progressSlider];
    }
}

- (UIButton *)collectButton
{
    if (!_collectButton) {
        _collectButton = [UIButton new];
        [_collectButton setImage:[UIImage imageNamed:@"btn_share_nor_white"] forState:UIControlStateNormal];
        [_collectButton setImage:[UIImage imageNamed:@"btn_share_nor_hl"] forState:UIControlStateSelected];
        [_collectButton addTarget:self action:@selector(clickedCollect:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectButton;
}

- (UIButton *)shareButton
{
    if (!_shareButton) {
        _shareButton = [UIButton new];
        [_shareButton setImage:[UIImage imageNamed:@"VideoPlayer_share01"] forState:UIControlStateNormal];
        [_shareButton setImage:[UIImage imageNamed:@"video_fullscreen"] forState:UIControlStateSelected];
        [_shareButton addTarget:self action:@selector(clickedShare:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}

- (UIButton *)likeButton
{
    if (!_likeButton) {
        _likeButton = [UIButton new];
        [_likeButton setImage:[UIImage imageNamed:@"VideoPlayer_favourite02"] forState:UIControlStateNormal];
        [_likeButton setImage:[UIImage imageNamed:@"VideoPlayer_liebiao_shoucang_highlight"] forState:UIControlStateSelected];
        [_likeButton addTarget:self action:@selector(clickedLike:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeButton;
}

//- (UIButton *)downloadButton
//{
//    if (!_downloadButton) {
//        _downloadButton = [UIButton new];
//        [_downloadButton setImage:[UIImage imageNamed:@"VideoPlayer_download01"] forState:UIControlStateNormal];
//        [_downloadButton addTarget:self action:@selector(clickedDownload:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _downloadButton;
//}

- (UIButton *)giftButton
{
    if (!_giftButton) {
        _giftButton = [UIButton new];
        [_giftButton setImage:[UIImage imageNamed:@"public_reward02"] forState:UIControlStateNormal];
        [_giftButton addTarget:self action:@selector(clickedGift:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _giftButton;
}

@end
