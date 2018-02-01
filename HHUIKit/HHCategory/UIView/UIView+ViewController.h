//
//  UIView+ViewController.h
//  FunnyTicket
//
//  Created by Xun on 17/4/19.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewController)

/// 控制器
@property (nonatomic, weak) UIViewController *viewController;

/// 父控制器
@property (nonatomic, weak) UIViewController *parentViewController;

/// 终级父控制器（一直遍历父控制器，直至父控制器为空，虽然TabBarController和NavigationController也是父控制器，但是此处有做限制，遇到这两类父控制器，也停止遍历）
@property (nonatomic, weak) UIViewController *finalParentViewController;

/// 导航控制器
@property (nonatomic, weak) UINavigationController *navigationController;

/// Tabbar
@property (nonatomic, weak) UITabBarController *tabbarController;

@end
