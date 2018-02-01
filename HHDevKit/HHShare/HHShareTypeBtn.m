//
//  HHShareTypeBtn.m
//  FunnyTicket
//
//  Created by tasama on 17/4/19.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHShareTypeBtn.h"
#import <HHUIKit/HHUIKit.h>
@implementation HHShareTypeBtn

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //填写布局约束
    self.imageView.frame = CGRectMake(0, 0, self.zf_width, self.zf_width);
    self.titleLabel.frame = CGRectMake(0, self.imageView.zf_bottom + 5, self.zf_width, 15);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


@end
