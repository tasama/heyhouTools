//
//  UITabBar+littleRedDotBadge.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 8/11/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "UITabBar+littleRedDotBadge.h"

#define TabbarItemNums 5.0    //tabbar的数量

@implementation UITabBar (littleRedDotBadge)

- (void)showBadgeOnItemIndex:(int)index{
    
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index + 0.7) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.2 * tabFrame.size.height) - 4;
    badgeView.frame = CGRectMake(x, y, 8, 8);
    badgeView.layer.cornerRadius = badgeView.frame.size.width / 2;
    
    [self addSubview:badgeView];
    
}

- (void)hideBadgeOnItemIndex:(int)index{
    
    //移除小红点
    [self removeBadgeOnItemIndex:index];
    
}

- (void)removeBadgeOnItemIndex:(int)index{
    
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888 + index) {
            [subView removeFromSuperview];
        }
    }
}

@end
