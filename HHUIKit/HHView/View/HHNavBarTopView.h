//
//  HHNavBarTopView.h
//  FunnyTicket
//
//  Created by XiaoZefeng on 14/10/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHNavBarTopView : UIView
//标题
@property (nonatomic , strong)NSArray *titles;
//当前下标
@property (nonatomic , assign)NSInteger currentIndex;

@property (nonatomic )BOOL autoLayout;

@property (nonatomic , strong)UIColor * btnSelectColor;

@property (nonatomic , strong)UIColor * lineColor;

@property (nonatomic , strong)UIColor * btnNormalColor;

@property (nonatomic , copy)void (^clickedButtonAtIndex)(NSInteger buttonIndex);

- (instancetype)initWithTitles:(NSArray *)titles;

- (void)setRedPointWithIndexs:(NSArray *)indexs;

- (void)hideRedPointWithIndexs:(NSArray *)indexs;

@end
