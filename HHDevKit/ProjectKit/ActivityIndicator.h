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
//  ActivityIndicator.h
//  ProjectKit
//
//  Created by xun on 16/12/12.
//  Copyright © 2016年 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityIndicator : NSObject
/**
 展示活动指示器
 */
+ (void)show;
+ (void)showWithMask;
+ (void)showOnView:(UIView *)view;


/**
 隐藏活动指示器
 */
+ (void)hide;
+ (void)hideWithCustomView:(UIView *)customView;

@end
