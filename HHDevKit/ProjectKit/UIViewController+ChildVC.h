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
//  UIViewController+ChildVC.h
//  ProjectKit
//
//  Created by xun on 16/12/12.
//  Copyright © 2016年 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ChildVC)

- (void)addChildVC:(UIViewController *)childVC;

- (void)addChildVC:(UIViewController *)childVC
         withFrame:(CGRect)frame;

- (void)removeChildVC:(UIViewController *)childVC;

- (void)removeChildVC:(UIViewController *)childVC
        withAnimation:(void(^)())animation;

- (void)removeFromParentVC;
- (void)removeFromParentVCWithAnimation:(void(^)())animation;

@end
