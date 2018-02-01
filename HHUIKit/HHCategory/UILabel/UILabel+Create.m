//
//  UILabel+ZFUtil.m
//  HHUIKit
//
//  Created by xheng on 3/11/17.
//

#import "UILabel+Create.h"

@implementation UILabel (Create)
    
+ (UILabel *)labelWithFont:(UIFont *)font
{
        UILabel *label = [[UILabel alloc] init];
        [label setFont:font];
        return label;
}
+ (UILabel *)labelWithFont:(UIFont *)font textColor:(UIColor *)color
{
        UILabel *label = [self labelWithFont:font];
        label.textColor = color;
        return label;
}
    
@end
