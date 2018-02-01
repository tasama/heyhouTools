//
//  HHPlayerView.m
//  ZFPlayer_Demo
//
//  Created by XiaoZefeng on 10/7/17.
//  Copyright © 2017年 HH_XiaoZefeng. All rights reserved.
//

#import "HHPlayerView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "HHPlayer.h"
#import <UIImageView+WebCache.h>
#import "MCDownloadManager.h"
#import "HHOperationEndView.h"

@interface HHPlayerView ()<HHPlayerOperationViewDelegate, HHPlayerDelegate, HHOperationEndViewDelegate>

@property (nonatomic, strong) HHPlayer *player;

@property (nonatomic, strong) UIImageView *coverImageView;

@property (nonatomic) CGRect oldFrame; ///< small screen's frame

@property (nonatomic) BOOL playerState; ///< 默认不播放

@property (nonatomic) BOOL controlLight; ///< YES为控制亮度,NO为控制声音

@property (nonatomic, strong) UISlider *volumeSlider;

@property (nonatomic) double currentPlayTime;

@property (nonatomic, strong) HHOperationEndView *endView;

@end

@implementation HHPlayerView

- (void)dealloc
{
    [self.player removeObserver:self forKeyPath:@"state"];
    [self.player removeObserver:self forKeyPath:@"playState"];
    [self.player removeObserver:self forKeyPath:@"progress"];
}

- (instancetype)initWithFrame:(CGRect)frame URL:(NSString *)url
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.player];
        [self addSubview:self.coverImageView];
        [self addSubview:self.operationView];
        [self setUrl:url];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.player];
        [self addSubview:self.coverImageView];
        [self addSubview:self.operationView];
        [self addSubview:self.endView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (@available(iOS 11, *) && ([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height)) {
        
        CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.coverImageView.frame = rect;
        self.player.frame = rect;
        self.operationView.frame = rect;
        self.endView.frame = rect;
    } else {
        self.coverImageView.frame = self.bounds;
        self.player.frame = self.bounds;
        self.operationView.frame = self.bounds;
        self.endView.frame = self.bounds;
    }
}

#pragma mark - HHPlayerOperationViewDelegate

- (void)operationView:(HHPlayerOperationView *)operationView clickedBackButton:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(playerViewClickedBackAction:)]) {
        [_delegate playerViewClickedBackAction:self];
    }
}

- (void)operationView:(HHPlayerOperationView *)operationView clickedMoreButton:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(playerViewClickedMoreAction:)]) {
        [_delegate playerViewClickedMoreAction:self];
    }
}

- (void)operationView:(HHPlayerOperationView *)operationView clickedPlayButton:(UIButton *)btn
{
    if (btn.selected) { ///< play
        ///< check networking
        [self play];
    } else { ///< pause
        [self pause];
    }
}

- (void)operationView:(HHPlayerOperationView *)operationView clickedFullScreenButton:(UIButton *)btn
{
    self.operationView.fullScrren = btn.selected;
    
    if ([_delegate respondsToSelector:@selector(playerView:clickedFullScreen:)]) {
        [_delegate playerView:self clickedFullScreen:btn];
    }
}

- (void)operationView:(HHPlayerOperationView *)operationView clickedShareButton:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(playerView:clickedShareButton:)]) {
        [_delegate playerView:self clickedShareButton:btn];
    }
}

- (void)operationView:(HHPlayerOperationView *)operationView clickedDownloadButton:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(playerView:clickedDownloadButton:)]) {
        [_delegate playerView:self clickedDownloadButton:btn];
    }
}

- (void)operationView:(HHPlayerOperationView *)operationView clickedLikeButton:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(playerView:clickedLikeButton:)]) {
        [_delegate playerView:self clickedLikeButton:btn];
    }
}

- (void)operationView:(HHPlayerOperationView *)operationView clickedCollectButton:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(playerView:clickedCollectButton:)]) {
        [_delegate playerView:self clickedCollectButton:btn];
    }
}

- (void)operationView:(HHPlayerOperationView *)operationView clickedGiftButton:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(playerView:clickedGiftButton:)]) {
        [_delegate playerView:self clickedGiftButton:btn];
    }
}

- (void)operationView:(HHPlayerOperationView *)operationView beginMoved:(HHPanDirection)panDirection atPoint:(CGPoint)point
{
    if (panDirection == HHPanDirectionHorizontalMoved) {
        
        if (self.operationView.lockEnable) {
            
            return;
        }
        [self.player.player pause];
    } else {
        if (point.x > self.operationView.bounds.size.width / 2) {
            self.controlLight = NO;
        }else { // 状态改为显示亮度调节
            self.controlLight = YES;
        }
    }
}

- (void)operationView:(HHPlayerOperationView *)operationView changeMoved:(HHPanDirection)panDirection atPoint:(CGPoint)point
{
    if (panDirection == HHPanDirectionVerticalMoved) {
        if (self.controlLight) {
            ///< 调节亮度
            ([UIScreen mainScreen].brightness -= point.y / 10000);
        } else { ///< 调节声音
            self.volumeSlider.value -= point.y / 10000;
        }
    } else {
        
        if (self.operationView.lockEnable) {
            
            return;
        }
        _currentPlayTime += point.x / 600;
        CMTime changedTime = CMTimeMakeWithSeconds(_currentPlayTime, 1);
        [self.player.player seekToTime:changedTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    }
}

- (void)operationView:(HHPlayerOperationView *)operationView endMoved:(HHPanDirection)panDirection atPoint:(CGPoint)point
{
    if (panDirection == HHPanDirectionHorizontalMoved) {
        
        if (self.operationView.lockEnable) {
            
            return;
        }
        if (self.player.isPlaying) {
            [self.player play];
            [self.operationView showAllSubviews];
        }
    }
}

- (void)operationView:(HHPlayerOperationView *)operationView tapProgressSlider:(UISlider *)slider
{
    [self.player seekToTime:self.player.duration * slider.value];
}

#pragma mark - HHPlayerDelegate

- (void)player:(HHPlayer *)player refreshCurrentTime:(double)currentTime
{
    NSInteger minit = currentTime / 60;
    NSInteger second = currentTime - 60 * minit;
    NSString *str = [NSString stringWithFormat:@"%02zd:%02zd",minit,second];
    self.operationView.currentTime = str;
    if ([self.delegate respondsToSelector:@selector(playerViewTimeCurrent:duration:)]) {
        
        [self.delegate playerViewTimeCurrent:currentTime duration:player.duration];
    }
}

int playCount = 0;

- (void)playerDidPlayFinished:(HHPlayer *)player
{
    playCount++;
    NSLog(@"播放完了%d次...",playCount);
    if (self.player.isRepeats) {
        return;
    }
    if (self.isFullScreen) {
        self.endView.backButton.hidden = NO;
    } else {
        self.endView.backButton.hidden = YES;
    }
    _currentPlayTime = 0;
    self.endView.hidden = NO;
}

#pragma mark - HHOperationEndViewDelegate

- (void)operationEndViewClickedBack:(UIButton *)btn
{
    self.operationView.fullScrren = NO;
    btn.hidden = YES;
    btn.selected = NO;
    if ([_delegate respondsToSelector:@selector(playerView:clickedFullScreen:)]) {
        [_delegate playerView:self clickedFullScreen:btn];
    }
}

- (void)operationEndViewClickedReplay:(UIButton *)btn
{
    self.endView.hidden = YES;
    [self play];
}

- (void)operationEndViewClickedShare:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(playerView:clickedShareButton:)]) {
        [_delegate playerView:self clickedShareButton:btn];
    }
}

- (void)operationEndViewClickedMore:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(playerViewClickedMoreAction:)]) {
        [_delegate playerViewClickedMoreAction:self];
    }
}

#pragma mark - Public Methods

- (void)play
{
    // 判断player 加载url状态
    if (self.player.state == HHMediaLoadStatePlayable) {
        
    }
    [self.player play];
    [self.operationView play];
    self.endView.hidden = YES;
    self.coverImageView.hidden = YES;
}

- (void)pause
{
    [self.player pause];
}

- (void)stop
{
    [self.operationView resetSubviewsState];
    [self.player pause];
}

- (void)setLikeEnable:(BOOL)isFav
{
    [self.operationView setLikeEnable:isFav];
}

- (void)setCollectEnable:(BOOL)enable
{
    [self.operationView setCollectEnable:enable];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (object == self.player && [keyPath isEqualToString:@"state"]) {
        if (self.player.state == HHMediaLoadStatePlayable) {
            //NSLog(@"正常播放...");
            NSInteger minit = self.player.duration / 60;
            NSInteger second = self.player.duration - 60 * minit;
            NSString *str = [NSString stringWithFormat:@"%02zd:%02zd",minit,second];
            self.operationView.allTime = str;
            // 判断是否进入播放状态 是 play 否 不操作
        } else if (self.player.state == HHMediaLoadStateStalled) {
            NSLog(@"我卡了... 等等我");
            
            [self.operationView hideAllSubviews];
            self.operationView.loading = YES;
            if ([_delegate respondsToSelector:@selector(playerViewLoadingMedia:)]) {
                [_delegate playerViewLoadingMedia:self];
            }
        } else {
            //NSLog(@"加载失败...");
            
            if ([_delegate respondsToSelector:@selector(playerViewMediaSourceUnknown:)]) {
                [_delegate playerViewMediaSourceUnknown:self];
            }
        }
    } else if (object == self.player && [keyPath isEqualToString:@"progress"]) {
        self.operationView.slideValue = self.player.progress;
        _currentPlayTime = self.operationView.slideValue * self.player.duration;
    } else if (object == self.player && [keyPath isEqualToString:@"playState"]) {
        
        if (self.player.playState == HHPlayerPlayStateStartToPlay) {
            
            NSLog(@"好了，继续播放");
            self.operationView.loading = NO;
        }
    }
}

#pragma mark - Setters And Getters

- (void)setUrl:(NSString *)url
{
    if (!url || url.length == 0) {
        return;
    }
    _url = [url copy];
    
    MCDownloadReceipt *receipt = [[MCDownloadManager defaultInstance] downloadReceiptForURL:_url];
    NSURL *URL;
    if (receipt.state == MCDownloadStateCompleted || receipt.totalBytesWritten == receipt.totalBytesExpectedToWrite) {
        URL = [NSURL fileURLWithPath:receipt.filePath];
    } else {
        URL = [NSURL URLWithString:_url];
    }
    [self.player updatePlayerWithURL:URL];
    [self.operationView hideAllSubviews];
    self.operationView.loading = YES;
}

- (BOOL)isPlay
{
    return self.player.isPlaying;
}

- (void)setCover:(NSString *)cover
{
    UIImage *image = [UIImage imageNamed:cover];
    if (!image) {
        return;
    }
    _cover = [cover copy];
    self.coverImageView.image = image;
}

- (void)setRemoteCover:(NSString *)remoteCover
{
    if (!remoteCover || remoteCover.length == 0) {
        return;
    }
    _remoteCover = [remoteCover copy];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:_remoteCover]];
}

- (void)setFullScreen:(BOOL)fullScreen
{
    _fullScreen = fullScreen;
    self.endView.backButton.hidden = !fullScreen;
    self.operationView.fullScrren = fullScreen;
}

- (void)setMediaTitle:(NSString *)mediaTitle
{
    _mediaTitle = [mediaTitle copy];
    self.operationView.mediaTitle = mediaTitle;
}

- (void)setRepeats:(BOOL)repeats
{
    _repeats = repeats;
    self.player.repeats = repeats;
}

- (BOOL)lockEnable
{
    return self.operationView.lockEnable;
}

#pragma mark - Lazy Loads

- (HHPlayer *)player
{
    if (!_player) {
        _player = [[HHPlayer alloc] init];
        _player.delegate = self;
        //_player.repeats = YES;
        [_player addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
        [_player addObserver:self forKeyPath:@"playState" options:NSKeyValueObservingOptionNew context:nil];
        [_player addObserver:self forKeyPath:@"progress" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _player;
}

- (HHPlayerOperationView *)operationView
{
    if (!_operationView) {
        _operationView = [[HHPlayerOperationView alloc] init];
        _operationView.loading = YES;
        _operationView.delegate = self;
    }
    return _operationView;
}

- (UISlider *)volumeSlider
{
    if (!_volumeSlider) {
        MPVolumeView *volumeView = [[MPVolumeView alloc] init];
        
        for (UIView *view in [volumeView subviews]){
            if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
                _volumeSlider = (UISlider *)view;
                break;
            }
        }
    }
    return _volumeSlider;
}

- (UIImageView *)coverImageView
{
    if (!_coverImageView) {
        _coverImageView = [UIImageView new];
        _coverImageView.userInteractionEnabled = YES;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImageView.clipsToBounds = YES;
    }
    return _coverImageView;
}

- (HHOperationEndView *)endView
{
    if (!_endView) {
        _endView = [HHOperationEndView new];
        _endView.delegate = self;
        _endView.hidden = YES;
    }
    return _endView;
}

@end
