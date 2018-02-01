//
//  UIColor+setGradualChangingColor.h
//  FunnyTicket
//
//  Created by tasama on 17/7/10.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (setGradualChangingColor)

+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(UIColor *)fromHexColorStr toColor:(UIColor *)toHexColorStr;

+ (UIColor *)changeWithRate:(CGFloat)rate andStartColor:(UIColor *)startColor andEndColor:(UIColor *)endColor;

+ (UIImage *)drawChangingColorWithSize:(CGSize)size fromColor:(UIColor *)fromHexColorStr toColor:(UIColor *)toHexColorStr withLocation:(CGPoint)startPoint toLocation:(CGPoint)endPoint;

@end
