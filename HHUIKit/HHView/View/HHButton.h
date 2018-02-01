//
//  HHButton.h
//  FunnyTicket
//
//  Created by tasama on 16/10/17.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHButton : UIButton

+ (instancetype)initWithTitle:(NSString *)titleString andTitleColor:(UIColor *)color andTitleFont:(UIFont *)font andRed:(CGFloat)redius;

@property (nonatomic, assign) UIEdgeInsets edg;


@end
