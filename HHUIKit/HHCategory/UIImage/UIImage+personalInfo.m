//
//  UIImage+personalInfo.m
//  FunnyTicket
//
//  Created by tasama on 17/2/11.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import "UIImage+personalInfo.h"

@implementation UIImage (personalInfo)

+ (UIImage *)pSetMasterLevel:(NSInteger)masterLevel andStarLevel:(NSInteger)starLevel andLeavl:(NSInteger)level {
    
    return [UIImage pGetLevel:level];
}

+ (UIImage *)pGetLevel:(NSInteger)level {
    
    if (level == 1) {
        
        return [UIImage imageNamed:@"NewIcon_Level_Low"];
    } else if (level == 2) {
        
        return [UIImage imageNamed:@"NewIcon_Level_Mid"];
    } else if (level == 3) {
        
        return [UIImage imageNamed:@"NewIcon_Level_High"];
    } else {
        
        return nil;
    }
}

+ (UIImage *)pSetVipWithId:(NSInteger)vipId {
    
    //NSString *string = [NSString stringWithFormat:@"vip_level_%zd",vipId];
    return nil;//[UIImage imageNamed:string];
}

+ (UIImage *)pSetHaveShow:(BOOL)have {
    
    if (have) {
        
        return [UIImage imageNamed:@"lbs_xiutubiao"];
    } else {
        return nil;
    }
}

@end
