//
//  UIImage+HHScreenshot.h
//  FunnyTicket
//
//  Created by Xun on 17/6/5.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HHScreenshot)

/// 获取屏幕frame中图形
+ (UIImage *)imagewWithFrameOnScreen:(CGRect)frame;

+ (UIImage *)rh_imageFromImage:(UIImage *)image inRect:(CGRect)rect;

@end
