//
//  HHNormalInputCell.h
//  FunnyTicket
//
//  Created by XiaoZefeng on 14/4/17.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHNormalInputCell : UITableViewCell

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, copy) void (^inputEndBlock)(NSString *text);

@property (nonatomic, copy) void (^valueDidChange)(UITextField *textfield);

@property (nonatomic, assign) NSInteger maxCount;

@end
