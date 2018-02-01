//
//  HHAutoScrollTitleView.h
//  LoadingProgressAnimation
//
//  Created by Xun on 17/4/25.
//  Copyright © 2017年 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHAutoScrollTitleView : UIView

/// 文本
@property (nonatomic, strong) NSString *text;

/// 速度  piexl/s
@property (nonatomic, assign) CGFloat speed;

/// 颜色
@property (nonatomic, strong) UIColor *color;

/// 字体
@property (nonatomic, strong) UIFont *font;

- (void)start;
- (void)stop;

@end
