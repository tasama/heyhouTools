//
//  ZFShareView.h
//  FunnyTicket
//
//  Created by XiaoZefeng on 30/7/16.
//  Copyright © 2016年 肖泽峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZFShareView;

@protocol ZFShareViewDelegate <NSObject>

- (void)shareView:(ZFShareView *)view didClickAtIndex:(NSInteger )buttonIndex;

@end

@interface ZFShareView : UIView

@property (nonatomic , weak)id <ZFShareViewDelegate> delegate;

- (instancetype)initWithTarget:(id <ZFShareViewDelegate>)target;

- (void)show;

- (void)hide;

@end
