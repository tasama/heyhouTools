//
//  UIColor+Hex.h
//  Heyhou
//
//  Created by XiaoZefeng on 23/9/16.
//  Copyright © 2016年 XiaoZefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (BOOL)firstColor:(UIColor*)firstColor secondColor:(UIColor*)secondColor;

+ (UIColor *)randomColor;

@end
