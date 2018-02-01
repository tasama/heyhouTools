//
//  HHRefreshFooter.m
//  FunnyTicket
//
//  Created by tasama on 17/7/20.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHRefreshFooter.h"
#import "UIColor+Hex.h"
#import "HHUIConst.h"


@implementation HHRefreshFooter

- (void)prepare {
    
    [super prepare];
    
    self.stateLabel.font = [UIFont fontWithName:@"Lobster1.4" size:12];
    self.stateLabel.textColor = HH_COLOR_TEXT_SUB;
    [self setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
}


@end
