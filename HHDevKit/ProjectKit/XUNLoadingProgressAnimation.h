//
//  XUNLoadingProgressAnimation.h
//  ViperArchitective
//
//  Created by xun on 17/4/24.
//  Copyright © 2017年 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSString* XUNLoadingProgressKey;

@interface XUNLoadingProgressAnimation : UIView

/// 加载进度
@property (nonatomic, assign) float progress;


/**
 *  工厂方法，创建加载动画
 *
 *  @param key 动画类型key
 *  @return 动画
 */
+ (instancetype)animationWithKey:(XUNLoadingProgressKey)key;

- (void)showOnView:(UIView *)view;

- (void)remove;

@end

CA_EXTERN const XUNLoadingProgressKey XUNLoadingProgressCycle;
