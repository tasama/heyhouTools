//
//  UIImage+HHImageStates.m
//  FunnyTicket
//
//  Created by tasama on 17/2/4.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import "UIImage+HHImageStates.h"

@implementation UIImage (HHImageStates)

+ (NSString *)setMasterLevel:(NSInteger)masterLevel andStarLevel:(NSInteger)starLevel andLeavl:(NSInteger)level {
    
    if (level == 2) {
        
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
    } else if (level == 3) {
        
        NSString *starStr = [NSString stringWithFormat:@"star_level_%zd", starLevel];
        
        return starStr;
    } else {
        
        return nil;
    }
}

@end
