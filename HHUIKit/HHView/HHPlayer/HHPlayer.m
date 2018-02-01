//
//  HHNewPlayer.m
//  3.3UI_Demo
//
//  Created by XiaoZefeng on 21/7/17.
//  Copyright © 2017年 HH_XiaoZefeng. All rights reserved.
//

#import "HHPlayer.h"
#import "UIColor+Hex.h"
#import "UIView+ViewController.h"
#import "HHVideoLoadingAnimationView.h"

@interface HHPlayer ()
{
    BOOL _isIntoBackground; // 是否在后台
    AVPlayerItem *_playerItem;
    id _playTimeObserver; // 观察者
}

@property (nonatomic, readwrite) double duration;

@property (nonatomic, readwrite) float playableProgress;

@property (nonatomic, readwrite) double currentTime;

@property (nonatomic, readwrite) HHMediaLoadState state;

@property (nonatomic, readwrite) HHPlayerPlayState playState;

@property (nonatomic, readwrite, copy) NSString *mediaURL;

@property (nonatomic, assign) BOOL beginObserver;

@property (nonatomic, strong) HHVideoLoadingAnimationView *loadingView;

@end

@implementation HHPlayer

- (void)dealloc
{
    NSLog(@"HHPlayer dealloc");
    [self removeObserveAndNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.player removeTimeObserver:_playTimeObserver]; // 移除playTimeObserver
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _state = HHMediaLoadStateUnknown;
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _playerLayer.backgroundColor = [UIColor colorWithHexString:@"000000"].CGColor;
        [self.layer addSublayer:_playerLayer];
        [self addSubview:self.loadingView];
        [self.loadingView startAnimation];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _playerLayer.frame = self.bounds;
    self.loadingView.bounds = CGRectMake(0, 0, 30, 30);
    self.loadingView.center = self.center;
}

#pragma mark - Public Methods

- (void)updatePlayerWithURL:(NSURL *)url
{
    if (![self.mediaURL isEqualToString:[url absoluteString]]) {
        
        self.mediaURL = [url absoluteString];
        
        AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
        
        if (item) {
            
            if (_playerItem) {
                
                [self removeObserveAndNotification];
            }
            
            _playerItem = item;
            
            [self.player replaceCurrentItemWithPlayerItem:_playerItem];
            
            [self addObserverAndNotification];
            
            [self.loadingView startAnimation];
        }
    }
    
}

- (void)play
{
    NSLog(@"%@ play", self.superview.viewController);
    _isPlaying = YES;
    [self.player play]; // 调用avplayer 的play方法
}

- (void)pause
{
    _isPlaying = NO;
    [self.player pause];
}

- (void)seekToTime:(double)time
{
    if (_currentTime == time) {
        return;
    }
    [self.player pause];

    CMTime changedTime = CMTimeMakeWithSeconds(time, 1);
    
    [self.loadingView startAnimation];
    
    [_playerItem seekToTime:changedTime completionHandler:^(BOOL finished) {
        
        [self.loadingView endAnimation];
        // 跳转完成后做某事
        if (self.isPlaying) {
            [self play];
        }
    }];
}

#pragma mark - Private Methods

- (void)addObserverAndNotification
{
    NSLog(@"addObserverAndNotification --> %p",_playerItem);
    [_playerItem addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew) context:nil]; // 观察status属性， 一共有三种属性
    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil]; // 观察缓冲进度
    [self monitoringPlayback:_playerItem]; // 监听播放
    [self addNotification]; // 添加通知
}

- (void)monitoringPlayback:(AVPlayerItem *)item
{
    __weak typeof(self)WeakSelf = self;
    
    // 播放进度, 每秒执行1次
    _playTimeObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        __strong typeof(WeakSelf) strongSelf = WeakSelf;
        strongSelf.currentTime = (double)item.currentTime.value / item.currentTime.timescale;
        strongSelf.progress = strongSelf.currentTime / strongSelf.duration;
        // 通知刷新UI
        if ([strongSelf.delegate respondsToSelector:@selector(player:refreshCurrentTime:)]) {
            [strongSelf.delegate player:strongSelf refreshCurrentTime:strongSelf.currentTime];
        }
    }];
}

- (void)addNotification
{
    // 播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
    // 前台通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterForegroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
    // 后台通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)removeObserveAndNotification
{
    NSLog(@"removeObserveAndNotification --> %p",_playerItem);
    @try {
        
        //[self.player replaceCurrentItemWithPlayerItem:nil];
        [_playerItem removeObserver:self forKeyPath:@"status" context:nil];
        [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
        [_player removeTimeObserver:_playTimeObserver];
        _playTimeObserver = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    } @catch (NSException *exception) {
        
        NSLog(@"HHPlayer移除监听失败");
    }
}

// 已缓冲进度
- (NSTimeInterval)availableDurationRanges
{
    NSArray *loadedTimeRanges = [_playerItem loadedTimeRanges]; // 获取item的缓冲数组
    // discussion Returns an NSArray of NSValues containing CMTimeRanges
    
    // CMTimeRange 结构体 start duration 表示起始位置 和 持续时间
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue]; // 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds; // 计算总缓冲时间 = start + duration
    return result;
}

#pragma mark - Notification Callback

- (void)playbackFinished:(NSNotification *)noti
{
    if ([noti object] != _playerItem) {
        return;
    }
    // 是否无限循环
    [_playerItem seekToTime:kCMTimeZero]; // 跳转到初始
    
    if (self.isRepeats) {
        if (self.isPlaying) {
            [_player play]; // 是否无限循环
        }
    } else {
        self.isPlaying = NO;
    }
    if ([_delegate respondsToSelector:@selector(playerDidPlayFinished:)]) {
        [_delegate playerDidPlayFinished:self];
    }
}

- (void)enterForegroundNotification
{
    if (self.loadingView.isLoading) {
        
        [self.loadingView endAnimation];
        [self.loadingView startAnimation];
    }
}

- (void)enterBackgroundNotification
{

}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    AVPlayerItem *item = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if (_isIntoBackground) {
            return;
        } else { // 判断status 的 状态
            AVPlayerStatus status = [[change objectForKey:@"new"] intValue]; // 获取更改后的状态
            if (status == AVPlayerStatusReadyToPlay) {
                //NSLog(@"准备播放");
                // CMTime 本身是一个结构体
                CMTime duration = item.duration; // 获取视频长度

                self.duration = CMTimeGetSeconds(duration);
                self.state = HHMediaLoadStatePlayable;
                
            } else if (status == AVPlayerStatusFailed) {
                self.state = HHMediaLoadStateFailed;
                //NSLog(@"AVPlayerStatusFailed");
            } else {
                //NSLog(@"AVPlayerStatusUnknown");
                self.state = HHMediaLoadStateUnknown;
            }
        }
        
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDurationRanges]; // 缓冲时间
        CGFloat totalDuration = CMTimeGetSeconds(_playerItem.duration); // 总时间
        self.playableProgress = timeInterval / totalDuration;
        // 设置缓冲进度条
        if (self.playableProgress <= self.progress + 0.1f && self.playableProgress < 1.0f) {
            
            [self.loadingView startAnimation];
            self.playState = HHPlayerPlayStateStalled;
            self.state = HHMediaLoadStateStalled;
        } else if (self.isPlaying) {
            
            if (self.player.rate < 1 && !self.shortPause) {
                
                self.playState = HHPlayerPlayStateStartToPlay;
                [self.player play];
            }
        } else {
            
            self.playState = HHPlayerPlayStateStartToPlay;
            [self.loadingView endAnimation];
        }
        
        if (self.player.rate >= 1) {
            
            [self.loadingView endAnimation];
            self.playState = HHPlayerPlayStateStartToPlay;
        }
    }
}

#pragma mark - Lazy Loads

- (AVPlayer *)player
{
    if (!_player) {
        _player = [[AVPlayer alloc] init];
    }
    return _player;
}

- (HHVideoLoadingAnimationView *)loadingView {
    
    if (!_loadingView) {
        
        _loadingView = [[HHVideoLoadingAnimationView alloc] init];
    }
    return _loadingView;
}

@end
