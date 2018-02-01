//
//  HHBannerHandle.h
//  FunnyTicket
//
//  Created by XiaoZefeng on 11/11/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
//处理banner跳转
#import "HHBannerView.h"
@interface HHBannerHandle : NSObject<BannerViewDelegate, UIScrollViewDelegate>

@property (nonatomic , weak)UIViewController *superVC;

@property (nonatomic , weak)HHBannerView *bannerView;

@end
