//
//  UIImage+HHBarrage.h
//  FunnyTicket
//
//  Created by heyhou on 16/11/25.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HHBarrage)
+ (UIImage *)getBarrageImageWithVipId:(NSInteger)vipId;

+ (UIImage *)getMasterId:(NSInteger)masterId andStartId:(NSInteger)startId;
@end
