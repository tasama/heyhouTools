//
//  HHNavigationBar.m
//  Heyhou
//
//  Created by XiaoZefeng on 27/9/16.
//  Copyright © 2016年 XiaoZefeng. All rights reserved.
//

#import "HHNavigationBar.h"
#import "UIImage+Color.h"
#import "UIColor+Hex.h"

#define themeBackgroundColor [UIColor colorWithHexString:@"05101c"]

@interface HHNavigationBar ()


@end

@implementation HHNavigationBar

- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageWithColor:themeBackgroundColor];  //背景图片
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end
