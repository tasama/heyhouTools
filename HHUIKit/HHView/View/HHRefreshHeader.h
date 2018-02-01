//
//  HHRefreshHeader.h
//  FunnyTicket
//
//  Created by tasama on 17/7/14.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface HHRefreshHeader : MJRefreshComponent

/** 创建header */
+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
/** 创建header */
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

/** 忽略多少scrollView的contentInset的top */
@property (assign, nonatomic) CGFloat ignoredScrollViewContentInsetTop;

@property (nonatomic, assign) CGFloat upMoveOffset;

@property (nonatomic, strong) UIColor *startColor;

@property (nonatomic, strong) UIColor *endColor;

@property (nonatomic, strong) UIColor *startFinalColor;

@property (nonatomic, strong) UIColor *endFinalColor;

@end
