//
//  HHViewHeadrRefresh.h
//  FunnyTicket
//
//  Created by tasama on 17/7/10.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    HHViewRefreshStatePullToRefresh,
    HHViewRefreshStateReleaseStartRefresh,
    HHViewRefreshStateRefreshing,
    HHViewRefreshStateEndRefresh
    
} HHViewRefreshState;

@interface HHViewHeadrRefresh : UIView

@property (nonatomic, strong) UIColor *startColor;

@property (nonatomic, strong) UIColor *endColor;

@property (nonatomic, weak) UIView *refreshView;

@property (nonatomic, assign) HHViewRefreshState state;

+ (instancetype)refreshWithTarget:(id)target selector:(SEL)selector;

- (void)doRefreshAction;

- (void)endRefresh;

@end
