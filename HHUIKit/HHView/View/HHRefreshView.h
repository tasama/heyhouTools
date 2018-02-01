//
//  HHRefreshView.h
//  FunnyTicket
//
//  Created by XiaoZefeng on 7/11/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHRefreshView : UIView

@property (nonatomic , copy)void (^didRefresh)();

@end
