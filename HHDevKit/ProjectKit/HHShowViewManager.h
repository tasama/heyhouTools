//
//  HHShowViewManager.h
//  FunnyTicket
//
//  Created by Xun on 17/4/19.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    HHViewAppearLocationTop,
    HHViewAppearLocationCenter,
    HHViewAppearLocationBottom
    
}HHViewAppearLocation;

@interface HHShowViewManager : NSObject

+ (instancetype)shareManager;

- (void)showView:(UIView *)view withAppearLocation:(HHViewAppearLocation)location;

- (void)showView:(UIView *)view onView:(UIView *)superView appearLocation:(HHViewAppearLocation)location;

@end
