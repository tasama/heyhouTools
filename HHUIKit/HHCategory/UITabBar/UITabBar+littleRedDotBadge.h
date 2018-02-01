//
//  UITabBar+littleRedDotBadge.h
//  FunnyTicket
//
//  Created by XiaoZefeng on 8/11/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (littleRedDotBadge)

- (void)showBadgeOnItemIndex:(int)index;
- (void)hideBadgeOnItemIndex:(int)index;

@end
