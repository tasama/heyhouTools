//
//  HHPlayerView.h
//  ZFPlayer_Demo
//
//  Created by XiaoZefeng on 10/7/17.
//  Copyright © 2017年 HH_XiaoZefeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHPlayerOperationView.h"

@class HHPlayerView;

@protocol HHPlayerViewDelegate <NSObject>

- (void)playerViewClickedBackAction:(HHPlayerView *)playerView;

- (void)playerViewClickedMoreAction:(HHPlayerView *)playerView;

- (void)playerView:(HHPlayerView *)playerView clickedFullScreen:(UIButton *)btn;

- (void)playerView:(HHPlayerView *)playerView clickedShareButton:(UIButton *)btn;

- (void)playerView:(HHPlayerView *)playerView clickedDownloadButton:(UIButton *)btn;

- (void)playerView:(HHPlayerView *)playerView clickedLikeButton:(UIButton *)btn;

- (void)playerView:(HHPlayerView *)playerView clickedCollectButton:(UIButton *)btn;

- (void)playerView:(HHPlayerView *)playerView clickedGiftButton:(UIButton *)btn;

@optional
///< 播放失败,请检查网络
- (void)playerViewPlayFailed:(HHPlayerView *)playerView;
///< 正在加载
- (void)playerViewLoadingMedia:(HHPlayerView *)playerView;
///< 播放失败
- (void)playerViewMediaSourceUnknown:(HHPlayerView *)playerView;

- (void)playerViewTimeCurrent:(NSTimeInterval)currentTime duration:(NSTimeInterval)duration;

@end

@interface HHPlayerView : UIView

@property (nonatomic, copy) NSString *url;

@property (nonatomic, readonly) BOOL isPlay;        ///< 当前播放状态, 默认为NO

@property (nonatomic, copy) NSString *cover;        ///< 视频封面,本地路径

@property (nonatomic, copy) NSString *remoteCover;      ///< 视频封面,网络路径

@property (nonatomic, copy) NSString *mediaTitle;  ///< 多媒体标题

@property (nonatomic) BOOL repeats;

@property (nonatomic, readonly) BOOL lockEnable;

@property (nonatomic, getter=isFullScreen) BOOL fullScreen; 

@property (nonatomic, strong) HHPlayerOperationView *operationView;///< UI view

@property (nonatomic, weak) id <HHPlayerViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame URL:(NSString *)url;

- (void)play;

- (void)pause;

- (void)stop;

- (void)setLikeEnable:(BOOL)isFav;

- (void)setCollectEnable:(BOOL)enable;

@end
