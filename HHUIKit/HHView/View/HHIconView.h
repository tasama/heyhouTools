//
//  HHIconView.h
//  FunnyTicket
//
//  Created by 戴熙华 on 16/11/23.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHIconView : UIImageView
/**
 头像地址
 */
@property(nonatomic,copy) NSString *avatar;

/**
 厂牌等级
 */
@property(nonatomic,assign) NSInteger starLevel;

/**
 用户等级
 */
@property(nonatomic,assign) NSInteger alevel;

/**
 达人等级
 */
@property(nonatomic,assign) NSInteger masterLevel;

/**
 vip等级
 */
@property(nonatomic,assign) NSInteger vipLevel;

/**
 性别
 */
@property (nonatomic, assign) NSInteger sex;

@end
