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
//  UIView+XUNFrame.h
//  ProjectKit
//
//  Created by xun on 16/12/12.
//  Copyright © 2016年 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XUNFrame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

/// 填充父视图
- (void)fill;
- (void)fillWidth;
- (void)fillHeight;

//- (void)horizonalTrainling;
//- (void)verticalTrainling;
//- (void)horizonalLeading;
//- (void)verticalLeading;


@end
