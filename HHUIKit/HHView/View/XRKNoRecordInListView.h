//
//  XRKNoRecordInListView.h
//  YueDu
//
//  Created by liang on 15/11/3.
//  Copyright © 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRKNoRecordInListView : UIView

+ (XRKNoRecordInListView *)createView;

// 用在table foot view时使用下面函数设置
- (void)setTarget:(id)target withTitle:(NSString *)title icon:(NSString *)iconName buttonTitle:(NSString *)btnTitle btnAction:(SEL)action;

// 直接用在view中时使用
- (void)showInVC:(id)target withTitle:(NSString *)title icon:(NSString *)iconName buttonTitle:(NSString *)btnTitle btnAction:(SEL)action;

- (void)setButtonTitle:(NSString *)title;
@end
