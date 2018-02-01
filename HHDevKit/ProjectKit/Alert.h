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
//  Alert.h
//  ProjectKit
//
//  Created by xun on 16/12/12.
//  Copyright © 2016年 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"

#define IOS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


typedef void (^ActionBlock)();

XUNExtern UIAlertAction *alert_action(NSString *title, ActionBlock action);

@interface Alert : NSObject

+ (void)alertWithMsg:(NSString *)msg;

+ (void)alertWithTitle:(NSString *)title
                   msg:(NSString *)msg;

+ (void)alertWithTitle:(NSString *)title
                   msg:(NSString *)msg
         defaultAction:(UIAlertAction *)defaultAction;

+ (void)alertWithTitle:(NSString *)title
                   msg:(NSString *)msg
                action:(UIAlertAction *)action1
                action:(UIAlertAction *)action2;

/**
 *  弹出会话框
 *
 *  @param title   标题
 *  @param msg     信息
 *  @param action1 选项1
 *  @param action2 选项2
 *  @param vc      所要显示的视图控制器上
 */
+ (void)alertWithTitle:(NSString *)title
                   msg:(NSString *)msg
                action:(UIAlertAction *)action1
                action:(UIAlertAction *)action2
      onViewController:(UIViewController *)vc;

/**
 *  弹出脚页选择器   推荐iPad使用
 *
 *  @param actions 所有选择
 *  @param title   选择器标题
 *  @param view    箭头所指向视图
 */
+ (void)alertSheetWithActions:(NSArray <UIAlertAction *> *)actions
                        title:(NSString *)title
                       onView:(UIView *)view;
+ (void)alertSheetWithActions:(NSArray <UIAlertAction *> *)actions
                       onView:(UIView *)view;

/**
 *  弹出脚页选择器   仅iPhone可用
 *
 *  @param actions 所有选择
 *  @param title   选择器标题
 *  @param vc      所要显示的视图控制器上
 */
+ (void)alertSheetWithActions:(NSArray <UIAlertAction *> *)actions
                        title:(NSString *)title
             onViewController:(UIViewController *)vc;
+ (void)alertSheetWithActions:(NSArray <UIAlertAction *> *)actions
                        title:(NSString *)title;
+ (void)alertSheetWithActions:(NSArray <UIAlertAction *> *)actions;


@end
