//
//  UIButton+ZFUtil.h
//  HHUIKit
//
//  Created by xheng on 3/11/17.
//

#import <UIKit/UIKit.h>

@interface UIButton (Create)
    
+ (UIButton *)buttonWithFont:(UIFont *)font;
    
+ (UIButton *)buttonWithFont:(UIFont *)font textColor:(UIColor *)color;
    
+ (UIButton *)buttonWithImage:(UIImage *)image target:(id )target event:(SEL )selector;
    
+ (UIButton *)buttonWithFont:(UIFont *)font textColor:(UIColor *)color title:(NSString *)title;
    
+ (UIButton *)buttonWithFont:(UIFont *)font textColor:(UIColor *)color title:(NSString *)title image:(UIImage *)image;
    
+ (UIButton *)buttonWithFont:(UIFont *)font textColor:(UIColor *)color title:(NSString *)title target:(id )target event:(SEL )selector;
    
- (void)verticalButtonImageAndTitle:(CGFloat)spacing;
    
- (void)horizontalButtonImageAndTitle:(CGFloat)spacing;

@end
