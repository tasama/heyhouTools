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
//  Prompt.m
//  ProjectKit
//
//  Created by xun on 16/12/12.
//  Copyright © 2016年 Xun. All rights reserved.
//

#import "Prompt.h"
#import "Macro.h"


#define kDefaultCenter  CGPointMake(kScreenWidth / 2, kScreenHeight / 5 * 4)
#define kDefaultView    [UIApplication sharedApplication].keyWindow
#define kDuration       3

@implementation Prompt

+ (void)promptMsg:(NSString *)msg
{
    [Prompt promptMsg:msg onView:kDefaultView center:kDefaultCenter];
}

+ (void)promptMsg:(NSString *)msg onView:(UIView *)view
{
    [Prompt promptMsg:msg onView:view center:kDefaultCenter];
}

+ (void)promptMsg:(NSString *)msg center:(CGPoint)center
{
    [Prompt promptMsg:msg onView:kDefaultView center:center];
}

+ (void)promptMsg:(NSString *)msg onView:(UIView *)view center:(CGPoint)center
{
    UIView *prompt = [[UIView alloc] init];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.text = msg;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:15];
    lab.textColor = [UIColor whiteColor];
    lab.numberOfLines = 0;
    [prompt addSubview:lab];
    
    CGSize size = [lab sizeThatFits:CGSizeMake(kScreenWidth - 100.f, CGFLOAT_MAX)];
    lab.frame = CGRectMake(0.f, 0.f, size.width + 20.f, size.height + 20.f);
    prompt.frame = lab.frame;
    prompt.center = center;
    [view addSubview:prompt];
    
    prompt.layer.cornerRadius = 5.f;
    prompt.backgroundColor = [UIColor blackColor];
    [UIView animateWithDuration:kDuration animations:^{
        
        prompt.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [prompt removeFromSuperview];
    }];
}

@end
