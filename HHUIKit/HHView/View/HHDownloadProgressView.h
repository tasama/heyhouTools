//
//  HHDownloadProgressView.h
//  ZF_Demo
//
//  Created by XiaoZefeng on 2/5/17.
//  Copyright © 2017年 HH_XiaoZefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHDownloadProgressView : UIView

@property (nonatomic) CGFloat progressValue;

@property (nonatomic) CGFloat progressStrokeWidth;

@property (nonatomic, strong) UIColor * progressColor;

@property (nonatomic, strong) UIColor * progressTrackColor;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, copy) void (^clickCancelBlock)(HHDownloadProgressView *progressView);

- (void)show;

- (void)hide;

@end
