//
//  CapionView.h
//  FunnyTicket
//
//  Created by XiaoZefeng on 12/10/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CapionView : UIView

+ (instancetype)shareManager;

- (void)showText:(NSString *)text;

- (void)showTextInCenter:(NSString *)text;

- (void)showTextTitle:(NSString *)title andSubString:(NSString *)subString;

@end
