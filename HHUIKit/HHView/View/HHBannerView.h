//
//  BannerView.h
//  CellCountDown
//
//  Created by XiaoZefeng on 5/7/16.
//  Copyright © 2016年 肖泽峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHPageControl.h"

@class HHBannerView;

@protocol BannerViewDelegate <NSObject>

@optional

- (void)bannerView:(HHBannerView *)view didSelectAtIndex:(NSInteger )index;

@end

@interface HHBannerView : UIView <UIScrollViewDelegate>

@property (nonatomic )BOOL zoomEnable;//滚动是是否缩放 默认YES

@property (nonatomic )BOOL fullScreenEnable;

/**
 * 自定义初始化方法
 **/
- (instancetype)initWithTarget:(id <UIScrollViewDelegate , BannerViewDelegate>)target;

@property (nonatomic , strong)id dataSource;

@property (nonatomic , weak)id <BannerViewDelegate> delegate;

@property (nonatomic , strong)HHPageControl *pageControl;


/**
 * 加载本地图片
 **/
- (void)loadImages:(NSArray *)array;

/**
 * 加载网络图片
 **/
- (void)loadImagesWithUrl:(NSArray *)array;

/**
 * 滑动时抽屉效果
 **/
- (void)scroll;


@end
