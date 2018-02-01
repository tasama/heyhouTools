//
//  HHNavigationController.m
//  Heyhou
//
//  Created by XiaoZefeng on 27/9/16.
//  Copyright © 2016年 XiaoZefeng. All rights reserved.
//

#import "HHNavigationController.h"
#import "UIImage+Color.h"
#import "UIColor+Hex.h"
#import "HHNavigationBar.h"
#import "HHBasicViewController.h"
#import "HHUIConst.h"

@interface HHNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property(nonatomic, weak) UIViewController *currentShowVC;

@end

@implementation HHNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self)
    {
        self.interactivePopGestureRecognizer.delegate = self;
        self.delegate = self;
    }
    return self;
}

- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass
{
    self = [super initWithNavigationBarClass:navigationBarClass toolbarClass:toolbarClass];
    if (self)
    {
        self.interactivePopGestureRecognizer.delegate = self;
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:HH_COLOR_NAVIGATION_BAR] forBarMetrics:UIBarMetricsDefault];

    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:17.f]}];
    
    if (@available(iOS 11, *)) {
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, 0) forBarMetrics:UIBarMetricsDefault];
    } else {
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                             forBarMetrics:UIBarMetricsDefault];
    }
    
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:14.f]} forState:UIControlStateNormal];

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    if ([self.topViewController isKindOfClass:[viewController class]]) {
        
        return;
    }
    [super pushViewController:viewController animated:YES];
}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (1 == navigationController.viewControllers.count)
    {
        self.currentShowVC = nil;
    }
    else
    {
        self.currentShowVC = viewController;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer)
    {
        return (self.currentShowVC == self.topViewController);
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] &&
        [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)shouldAutorotate
{
    if ([self.topViewController isKindOfClass:[HHBasicViewController class]]) {
        return [self.topViewController shouldAutorotate];
    }
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([self.topViewController isKindOfClass:[HHBasicViewController class]]) {
        return [self.topViewController supportedInterfaceOrientations];
    } else {
        return UIInterfaceOrientationMaskPortrait; 
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

-(UIViewController *)childViewControllerForStatusBarHidden
{
    return self.topViewController;
}

@end
