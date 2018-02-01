//
//  UIView+leftVIew.h
//  FunnyTicket
//
//  Created by tasama on 17/1/18.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHInputTextCountView.h"

@interface UIView (leftVIew)

+ (UIView *)leftView;

+ (UIView *)rightCountViewWithLimit:(NSInteger)limit;

@end
