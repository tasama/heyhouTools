//
//  HHWelcomeView.h
//  Heyhou
//
//  Created by XiaoZefeng on 9/10/16.
//  Copyright © 2016年 XiaoZefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHWelcomeView : UIView

@property (nonatomic, strong)NSArray *images;//欢迎页图片

@property (nonatomic, copy)void (^enterApp)(NSInteger index);//点击进入app回调

@end
