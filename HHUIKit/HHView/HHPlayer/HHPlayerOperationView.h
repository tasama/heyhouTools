//
//  HHPlayerOperationView.h
//  ZFPlayer_Demo
//
//  Created by XiaoZefeng on 10/7/17.
//  Copyright © 2017年 HH_XiaoZefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

// 枚举值，包含水平移动方向和垂直移动方向
typedef NS_ENUM(NSInteger, HHPanDirection){
    HHPanDirectionHorizontalMoved, // 横向移动
    HHPanDirectionVerticalMoved    // 纵向移动
};

@class HHPlayerOperationView;

@protocol HHPlayerOperationViewDelegate <NSObject>

- (void)operationView:(HHPlayerOperationView *)operationView clickedBackButton:(UIButton *)btn;

- (void)operationView:(HHPlayerOperationView *)operationView clickedMoreButton:(UIButton *)btn;
///< if btn.selected = YES; should to play. otherwise to pause.
- (void)operationView:(HHPlayerOperationView *)operationView clickedPlayButton:(UIButton *)btn;
///< if btn.selected = YES; should to full screen.
- (void)operationView:(HHPlayerOperationView *)operationView clickedFullScreenButton:(UIButton *)btn;

///< business operation

- (void)operationView:(HHPlayerOperationView *)operationView clickedShareButton:(UIButton *)btn;

- (void)operationView:(HHPlayerOperationView *)operationView clickedDownloadButton:(UIButton *)btn;

- (void)operationView:(HHPlayerOperationView *)operationView clickedLikeButton:(UIButton *)btn;

- (void)operationView:(HHPlayerOperationView *)operationView clickedCollectButton:(UIButton *)btn;

- (void)operationView:(HHPlayerOperationView *)operationView clickedGiftButton:(UIButton *)btn;

@optional
///< tap gesture callback
- (void)operationView:(HHPlayerOperationView *)operationView beginMoved:(HHPanDirection)panDirection atPoint:(CGPoint)point;

- (void)operationView:(HHPlayerOperationView *)operationView changeMoved:(HHPanDirection)panDirection atPoint:(CGPoint)point;

- (void)operationView:(HHPlayerOperationView *)operationView endMoved:(HHPanDirection)panDirection atPoint:(CGPoint)point;

- (void)operationView:(HHPlayerOperationView *)operationView tapProgressSlider:(UISlider *)slider;

@end

@interface HHPlayerOperationView : UIView

@property (nonatomic, getter=isFullScreen) BOOL fullScrren;

@property (nonatomic, copy) NSString *currentTime;

@property (nonatomic, copy) NSString *allTime;

@property (nonatomic) float slideValue;

@property (nonatomic, copy) NSString *mediaTitle;  ///< 多媒体标题

@property (nonatomic, readonly) BOOL lockEnable;

@property (nonatomic, assign) BOOL loading;

@property (nonatomic, weak) id <HHPlayerOperationViewDelegate> delegate;

@property (nonatomic, strong) UIButton *shareButton;

- (void)resetSubviewsState;

- (void)play;

- (void)setLikeEnable:(BOOL)isFav;

- (void)setCollectEnable:(BOOL)enable;

- (void)hideAllSubviews;

- (void)showAllSubviews;

@end
