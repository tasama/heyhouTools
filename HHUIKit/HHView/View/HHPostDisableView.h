//
//  HHPostDisableView.h
//  FunnyTicket
//
//  Created by tasama on 17/4/7.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHPostDisableView : UIView

@property (nonatomic, copy) NSString *tipMessageString;

@property (nonatomic, copy) void (^backBlock)();
@end
