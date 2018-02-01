//
//  HHAlertView.h
//  FunnyTicket
//
//  Created by XiaoZefeng on 14/10/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHTextField.h"
typedef NS_ENUM(NSInteger, HHAlertViewStyle)
{
    HHAlertViewStyleDefault = 0,
    HHAlertViewStyleSecureTextInput,//密码格式
    HHAlertViewStylePlainTextInput,//正常输入 单行输入
    HHAlertViewStyleLoginAndPasswordInput//输入帐号密码格式
};

@class HHAlertView;
@protocol HHAlertViewDelegate <NSObject>
@optional
- (void)HHAlertView:(HHAlertView *_Nonnull)alertView clickedButtonAtIndex:(NSInteger )buttonIndex;

@end

@interface HHAlertView : UIView

- (instancetype _Nullable)initWithTitle:(NSString *_Nullable)title message:( NSString *_Nullable)message delegate:(id <HHAlertViewDelegate> _Nullable)delegate cancelButtonTitle:(NSString *_Nullable)cancelButtonTitle otherButtonTitles:(NSString *_Nullable)otherButtonTitles, ... ;

- (void)show;
//_Nonnull _Nullable
@property (nonatomic , weak)id <HHAlertViewDelegate> _Nullable delegate;

//message
@property (nonatomic , strong)UILabel *_Nullable messageLabel;
//
@property (nonatomic , strong)HHTextField *_Nullable topTextField;//第一个输入框
@property (nonatomic , strong)HHTextField *_Nullable bottomTextField;//第二个输入框

@property (nonatomic , assign) HHAlertViewStyle alertViewStyle;

@property (nonatomic , strong)id _Nullable object;//带参数

@end
