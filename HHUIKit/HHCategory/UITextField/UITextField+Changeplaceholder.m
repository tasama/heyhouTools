//
//  UITextField+Changeplaceholder.m
//  ios玉林开发架构样版(兼容国内国际化)
//
//  Created by 夏玉林 on 16/12/22.
//  Copyright © 2016年 夏玉林. All rights reserved.
//

#import "UITextField+Changeplaceholder.h"

#import <objc/message.h>

NSString * const changeplaceholderColorName = @"changeplaceholderColor";

@implementation UITextField (Changeplaceholder)

+ (void)load
{
    // 获取 setChangeplaceholder
    Method setChangeplaceholder = class_getInstanceMethod(self,@selector(setChangeplaceholder:) );
    // 获取bs_setPlaceholder
   Method bs_setChangeplaceholder = class_getInstanceMethod(self, @selector(bs_Changeplaceholder:));
    // 交换方法
    method_exchangeImplementations(setChangeplaceholder, bs_setChangeplaceholder);
    
}

// OC最喜欢懒加载,用的的时候才会去加载

// 需要给系统UITextField添加属性,只能使用runtime
- (void)setChangeplaceholderColor:(UIColor *)changeplaceholderColor{
    // 设置关联
    objc_setAssociatedObject(self,(__bridge const void *)(changeplaceholderColorName), changeplaceholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // 设置占位文字颜色
    UILabel *placeholderLabel = [self valueForKeyPath:@"placeholderLabel"];
    
    placeholderLabel.textColor = changeplaceholderColor;
}

- (UIColor *)changeplaceholderColor{
    
    // 返回关联
    
    return objc_getAssociatedObject(self, (__bridge const void *)(changeplaceholderColorName));}

// 设置占位文字,并且设置占位文字颜色
- (void)bs_setChangeplaceholder:(NSString *)changeplaceholder
{
    // 1.设置占位文字
    [self bs_setChangeplaceholder:changeplaceholder];
    
    // 2.设置占位文字颜色

    self.changeplaceholderColor = self.changeplaceholderColor;
}

@end
