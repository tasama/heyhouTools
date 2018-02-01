//
//  \\      //     ||          ||     ||\        ||
//   \\    //      ||          ||     ||\\       ||
//    \\  //       ||          ||     || \\      ||
//     \\//        ||          ||     ||  \\     ||
//      /\         ||          ||     ||   \\    ||
//     //\\        ||          ||     ||    \\   ||
//    //  \\       ||          ||     ||     \\  ||
//   //    \\      ||          ||     ||      \\ ||
//  //      \\      \\        //      ||       \\||
// //        \\      \\======//       ||        \||
//
//
//  UIViewController+ChildVC.m
//  ProjectKit
//
//  Created by xun on 16/12/12.
//  Copyright © 2016年 Xun. All rights reserved.
//

#import "UIViewController+ChildVC.h"

@implementation UIViewController (ChildVC)

- (void)addChildVC:(UIViewController *)childVC
{
    [self addChildViewController:childVC];
    [childVC willMoveToParentViewController:self];
    [self.view addSubview:childVC.view];
    [childVC didMoveToParentViewController:self];
}

- (void)addChildVC:(UIViewController *)childVC
         withFrame:(CGRect)frame
{
    childVC.view.frame = frame;
    [self addChildVC:childVC];
}

- (void)removeChildVC:(UIViewController *)childVC
{
    [self removeChildVC:childVC withAnimation:nil];
}

- (void)removeChildVC:(UIViewController *)childVC
        withAnimation:(void (^)())animation
{
    if (animation)
    {
        [UIView animateWithDuration:0.25f animations:^{
            
            animation();
            
        } completion:^(BOOL finished) {
            
            if (finished)
            {
                [childVC removeFromParentVC];
            }
            
        }];
    }
    else
    {
        [childVC removeFromParentVC];
    }
}

- (void)removeFromParentVC
{
    [self.view removeFromSuperview];
    [self willMoveToParentViewController:nil];
    [self removeFromParentViewController];
}

- (void)removeFromParentVCWithAnimation:(void (^)())animation
{
    if (animation)
    {
        [UIView animateWithDuration:0.25f animations:^{
            
            animation();
            
        } completion:^(BOOL finished) {
            
            if (finished)
            {
                [self removeFromParentVC];
            }
            
        }];
    }
    else
    {
        [self removeFromParentVC];
    }
}

@end
