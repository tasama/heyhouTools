//
//  HHBasicViewController.h
//  Heyhou
//
//  Created by XiaoZefeng on 24/9/16.
//  Copyright © 2016年 XiaoZefeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@class EMMessage;

typedef void(^refreshData)();

@interface HHBasicViewController : UIViewController
#if 0 //由每个项目的基类自行实现该方法
- (void)didReceiveLocalNotification:(UILocalNotification *)notification;

- (void)didReceiveUserNotification:(UNNotification *)notification;

- (void)playSoundAndVibration;

- (void)showNotificationWithMessage:(EMMessage *)message;
#endif
//默认添加到view的中间
- (void)showNoDataInView:(UIView *)view;
//添加到view的指定区域
- (void)showNoDataInView:(UIView *)view InRect:(CGRect )rect;
//添加到view上带message
- (void)showNoDataInView:(UIView *)view andMessage:(NSString *)message;
//添加到View上的指定区域自定义文字图片
- (void)showNoDataInView:(UIView *)view andMessage:(NSString *)message andPlaceholderImg:(UIImage *)image InRect:(CGRect )rect;

- (void)hideNoDataView;
//默认添加到view的中间
- (void)showRefreshInView:(UIView *)view didRefresh:(refreshData )completion;
//添加到view的指定区域
- (void)showRefreshInView:(UIView *)view InRect:(CGRect )rect didRefresh:(refreshData )completion;

- (void)hideRefreshView;
//无导航栏的错误页
- (void)showPostDisableInViewWithOutNav:(UIView *)view withMessage:(NSString *)message;

- (void)hidePostDisableInViewWithOutNav;

- (void)showNoContentInView:(UIView *)view message:(NSString *)message;

- (void)showNoContentInView:(UIView *)view InRect:(CGRect)rect message:(NSString *)message;

- (void)hideNoContentView;

#define BASIC_CENTER_RECT CGRectMake((view.zf_width - view.zf_width * .4) / 2.0f, view.zf_height * .5 - view.zf_width * .1 - 17.5, view.zf_width * .4, view.zf_width * .2 + 35)

@end
