//
//  HHFSScrollView.h
//  TestScrollView
//
//  Created by tasama on 17/7/17.
//  Copyright © 2017年 tasama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+speedLevel.h"

@class HHFSScrollView;
@protocol HHFSScrollViewDelegate <NSObject>

- (void)HHFSScrollViewDidScrollingWithScrollView:(HHFSScrollView *)scrollView;

- (void)HHFSScrollViewDidEndDraggingWithState:(BOOL)nextPage;

@end

@interface HHFSScrollView : UIView

@property (nonatomic, assign) CGSize contentSize;

@property (nonatomic, assign) BOOL *pageEnable;

@property (nonatomic, weak) id <HHFSScrollViewDelegate> delegate;

- (void)nextPageAction;

- (void)backAction;

@end
