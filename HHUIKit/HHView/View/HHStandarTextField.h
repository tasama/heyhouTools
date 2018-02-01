//
//  HHStandarTextField.h
//  FunnyTicket
//
//  Created by Xun on 17/4/28.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XUNTextFieldValidator;

@interface HHStandarTextField : UITextField

/// 校验器
@property (nonatomic, strong) XUNTextFieldValidator *validator;

/// 提示文字颜色
@property (nonatomic, strong) UIColor *pColor;

@end

/// 输入框校验器，待开发
@interface XUNTextFieldValidator : NSObject

/// 校验方法，由子类实现
- (BOOL)validTextField:(UITextField *)textfield;

@end

@interface XUNNoBlankTextFieldValidator : XUNTextFieldValidator

@end
