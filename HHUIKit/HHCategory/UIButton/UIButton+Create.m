//
//  UIButton+ZFUtil.m
//  HHUIKit
//
//  Created by xheng on 3/11/17.
//

#import "UIButton+Create.h"
#import "HHUIConst.h"
@implementation UIButton (Create)
    
    +(UIButton *)buttonWithFont:(UIFont *)font
    {
        UIButton *btn = [[UIButton alloc] init];
        [btn.titleLabel setFont:font];
        return btn;
    }
    
+ (UIButton *)buttonWithFont:(UIFont *)font textColor:(UIColor *)color
    {
        UIButton *btn = [self buttonWithFont:font];
        [btn setTitleColor:color forState:UIControlStateNormal];
        return btn;
    }
    
+ (UIButton *)buttonWithImage:(UIImage *)image target:(id)target event:(SEL)selector
    {
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:image forState:UIControlStateNormal];
        if (target) {
            [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        }
        return btn;
    }
    
+ (UIButton *)buttonWithFont:(UIFont *)font textColor:(UIColor *)color title:(NSString *)title
    {
        UIButton *btn = [self buttonWithFont:font textColor:color];
        [btn setTitle:title forState:UIControlStateNormal];
        return btn;
    }
    
+ (UIButton *)buttonWithFont:(UIFont *)font textColor:(UIColor *)color title:(NSString *)title image:(UIImage *)image
    {
        UIButton *btn = [self buttonWithFont:font textColor:color title:title];
        [btn setImage:image forState:UIControlStateNormal];
        return btn;
    }
    
+ (UIButton *)buttonWithFont:(UIFont *)font textColor:(UIColor *)color title:(NSString *)title target:(id )target event:(SEL)selector
    {
        UIButton *btn = [self buttonWithFont:font textColor:color title:title];
        if (target) {
            [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        }
        return btn;
    }
    
- (void)verticalButtonImageAndTitle:(CGFloat)spacing {
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
}
    
- (void)horizontalButtonImageAndTitle:(CGFloat)spacing {
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageSize.width, 0, imageSize.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, titleSize.width + spacing * ScreenWidthScale, 0, -titleSize.width - spacing * ScreenWidthScale)];
}

@end
