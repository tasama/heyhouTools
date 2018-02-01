//
//  HHCustomShadowView.m
//  FunnyTicket
//
//  Created by tasama on 17/4/5.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import "HHCustomShadowView.h"
#import "UIColor+Hex.h"
#import "UIView+Frame.h"

@interface HHCustomShadowView ()



@end

@implementation HHCustomShadowView

single_implementation(HHCustomShadowView)
- (void)layoutSubviews {
    
    CGRect shadowRect = self.shadowRect;
    self.backgroundColor = [UIColor clearColor];
    [super layoutSubviews];
    CGFloat x = shadowRect.origin.x;
    CGFloat y = shadowRect.origin.y;
    CGFloat width = shadowRect.size.width;
    CGFloat height = shadowRect.size.height;
    UIColor *backGroundColor = [UIColor colorWithHexString:@"000000" alpha:.5f];
    UIColor *lineColor = [UIColor whiteColor];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(x, 0, width, y)];
    topView.backgroundColor = backGroundColor;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, x, self.zf_height)];
    leftView.backgroundColor = backGroundColor;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(x, y + height, width, self.zf_height - y - height)];
    bottomView.backgroundColor = backGroundColor;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(x + width, 0, self.zf_width - x - width, self.zf_height)];
    rightView.backgroundColor = backGroundColor;
    
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(topView.zf_left, topView.zf_bottom, width, 1.0f)];
    topLine.backgroundColor = lineColor;
    
    UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(x, topView.zf_bottom, 1.0f, height)];
    leftLine.backgroundColor = lineColor;
    
    UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(rightView.zf_left - 1.0f, topView.zf_bottom, 1.0f, height)];
    rightLine.backgroundColor = lineColor;
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(x, bottomView.zf_top - 1.0f, width, 1.0f)];
    bottomLine.backgroundColor = lineColor;
    
    
    [self addSubview:topView];
    [self addSubview:leftView];
    [self addSubview:bottomView];
    [self addSubview:rightView];
    
    [self addSubview:topLine];
    [self addSubview:leftLine];
    [self addSubview:bottomLine];
    [self addSubview:rightLine];

}

@end
