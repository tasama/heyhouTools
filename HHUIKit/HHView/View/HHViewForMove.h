//
//  HHViewForMove.h
//  FunnyTicket
//
//  Created by tasama on 17/7/17.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHView.h"

@interface HHViewForMove : HHView

@property (nonatomic, assign) CGFloat topLimit;

@property (nonatomic, copy) void (^dissMissBlock)();

@end
