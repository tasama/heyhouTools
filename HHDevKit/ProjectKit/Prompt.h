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
//  Prompt.h
//  ProjectKit
//
//  Created by xun on 16/12/12.
//  Copyright © 2016年 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Prompt : NSObject

+ (void)promptMsg:(NSString *)msg;

+ (void)promptMsg:(NSString *)msg
           center:(CGPoint)center;

+ (void)promptMsg:(NSString *)msg
           onView:(UIView *)view;

+ (void)promptMsg:(NSString *)msg
           onView:(UIView *)view
           center:(CGPoint)center;

@end
