//
//  UIImage+HHBarrage.m
//  FunnyTicket
//
//  Created by heyhou on 16/11/25.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "UIImage+HHBarrage.h"

@implementation UIImage (HHBarrage)

+ (UIImage *)getBarrageImageWithVipId:(NSInteger)vipId
{
    NSString *string = [NSString stringWithFormat:@"vip_level_%zd",vipId];
    return [UIImage imageNamed:string];
}

+ (UIImage *)getMasterId:(NSInteger)masterId andStartId:(NSInteger)startId {
    
    UIImage *image = [UIImage imageNamed:[self setMasterLevel:masterId andStarLevel:startId]];
    
    return image;
}

+ (NSString *)setMasterLevel:(NSInteger)masterLevel andStarLevel:(NSInteger)starLevel {
    
    
    if (starLevel != 0) { //优先厂牌
        
        NSString *starStr = [NSString stringWithFormat:@"star_level_%zd", starLevel];
        
        return starStr;
    } else {
        
        NSString *lastStr = @"";
        switch (masterLevel) {
            case 1:
                lastStr = @"d";
                break;
            case 2:
                lastStr = @"c";
                break;
            case 3:
                lastStr = @"b";
                break;
            case 4:
                lastStr = @"a";
                break;
            case 5:
                lastStr = @"s";
                break;
                
            default:
                break;
                
        }
        return [NSString stringWithFormat:@"master_level_%@",lastStr];
    }
}



@end
