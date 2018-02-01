//
//  ZFNextRunlooperRunner.h
//  ZFPlayer_Demo
//
//  Created by XiaoZefeng on 12/7/17.
//  Copyright © 2017年 HH_XiaoZefeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHNextRunlooperRunner : NSObject

+ (void)runBlock:(void(^)())run;

@end
