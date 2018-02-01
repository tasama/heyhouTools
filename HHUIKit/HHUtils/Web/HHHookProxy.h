//
//  HHHookProxy.h
//  FunnyTicket
//
//  Created by XiaoZefeng on 10/11/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HHHookProxy <NSObject>
/**
 *  在此方法内进行hook操作
 */

@optional

+ (void)hookProcess;

+ (void)hookSDWebImage;

@end
