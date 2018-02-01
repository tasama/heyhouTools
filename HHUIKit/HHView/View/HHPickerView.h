//
//  HHPickerView.h
//  FunnyTicket
//
//  Created by XiaoZefeng on 23/11/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHPickerView : UIView

@property (nonatomic , copy)void (^clickedOK)(NSString *text);

@property (nonatomic , strong)NSArray *titles;

- (void)show;

- (void)hide;

@end
