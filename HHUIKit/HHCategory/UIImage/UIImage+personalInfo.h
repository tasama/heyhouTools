//
//  UIImage+personalInfo.h
//  FunnyTicket
//
//  Created by tasama on 17/2/11.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (personalInfo)

+ (UIImage * _Nullable)pSetMasterLevel:(NSInteger)masterLevel andStarLevel:(NSInteger)starLevel andLeavl:(NSInteger)level;

+ (UIImage * _Nullable)pGetLevel:(NSInteger)level;

+ (UIImage * _Nullable)pSetVipWithId:(NSInteger)vipId;

+ (UIImage * _Nullable)pSetHaveShow:(BOOL)have;

@end
