//
//  HHWebViewLoadFailedView.h
//  FunnyTicket
//
//  Created by XiaoZefeng on 2017/3/23.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHWebViewLoadFailedView : UIView

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIButton *reloadButton;

@property (nonatomic, copy) void (^reload)();

@end
