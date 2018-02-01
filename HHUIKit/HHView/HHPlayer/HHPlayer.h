//
//  HHNewPlayer.h
//  3.3UI_Demo
//
//  Created by XiaoZefeng on 21/7/17.
//  Copyright © 2017年 HH_XiaoZefeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSInteger, HHMediaLoadState) {
    HHMediaLoadStateUnknown = 0,
    HHMediaLoadStatePlayable,
    HHMediaLoadStateStalled, // 停滞状态
    HHMediaLoadStateFailed
};

typedef NS_ENUM(NSInteger, HHPlayerPlayState) {
    
    HHPlayerPlayStateStartToPlay = 1, //开始播放
    HHPlayerPlayStateStalled //停滞
};

@class HHPlayer;

@protocol HHPlayerDelegate <NSObject>

@optional

- (void)player:(HHPlayer *)player refreshCurrentTime:(double)currentTime;
///< 暂时无效
- (void)playerDidPlayFinished:(HHPlayer *)player;

@end

@interface HHPlayer : UIView

// AVPlayer 控制视频播放
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@property (nonatomic, strong) AVPlayer *player;
// 播放状态
@property (nonatomic, assign) BOOL isPlaying;
// 当前加载资源的总长度
@property (nonatomic, readonly) double duration;
// 当前播放的时间
@property (nonatomic, readonly) double currentTime;
// 当前预加载的进度
@property (nonatomic, readonly) float playableProgress;
// 当前播放进度
@property (nonatomic) float progress;
// 是否重复播放, 默认为NO
@property (nonatomic, getter=isRepeats) BOOL repeats;
// URL资源的网络状态
@property (nonatomic, readonly) HHMediaLoadState state;

@property (nonatomic, readonly) HHPlayerPlayState playState; //监听播放状态

@property (nonatomic, assign) BOOL shortPause; //是否暂时停滞

@property (nonatomic, readonly, copy) NSString *mediaURL;

@property (nonatomic, weak) id <HHPlayerDelegate> delegate;

// 传入视频地址
- (void)updatePlayerWithURL:(NSURL *)url;
// 播放
- (void)play;
// 暂停
- (void)pause;

- (void)seekToTime:(double)time;

@end
