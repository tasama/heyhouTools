//
//  HHTextField.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 13/10/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "HHTextField.h"
#import "UIColor+Hex.h"
#import <HHFoundation/HHConst.h>
#import "HHUIConst.h"




@implementation HHTextField
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = HH_COLOR_24_GRAY;
        self.keyboardType = UIKeyboardTypeNumberPad;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.font = customFont;
        self.textColor = HH_COLOR_THEME_BACKGROUND;
    }
    return self;
}

@end
