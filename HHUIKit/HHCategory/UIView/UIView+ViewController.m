//
//  UIView+ViewController.m
//  FunnyTicket
//
//  Created by Xun on 17/4/19.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)

- (UIViewController *)viewController {
    
    return [self responderOfClass:[UIViewController class]];
}

- (UIViewController *)parentViewController {
    
    return [self viewController].parentViewController;
}

- (UIViewController *)finalParentViewController {
    
    UIViewController *viewController = [self viewController];
    
    while (viewController.parentViewController) {
        
        if ([viewController.parentViewController isKindOfClass:[UINavigationController class]] ||
            [viewController.parentViewController isKindOfClass:[UITabBarController class]]) {
            
            break;
        }
        else {
            
            viewController = viewController.parentViewController;
        }
    }
    
    return viewController;
}

- (UINavigationController *)navigationController {
    
    return [self responderOfClass:[UINavigationController class]];
}

- (UITabBarController *)tabbarController {
    
    return [self responderOfClass:[UITabBarController class]];
}

- (UIResponder *)responderOfClass:(Class)class {
    
    UIResponder *nextResponder = [self nextResponder];
    
    while (nextResponder) {
        
        if ([nextResponder isKindOfClass:class]) {
            
            break;
        }
        
        nextResponder = [nextResponder nextResponder];
    }
    
    return nextResponder;
}

@end
