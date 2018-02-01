//
//  UIView+speedLevel.h
//  TestScrollView
//
//  Created by tasama on 17/7/17.
//  Copyright © 2017年 tasama. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    speedLevelDefault,
    speedLevelHigh,
    speedLevelLow
    
} speedLevel;

@interface UIView (speedLevel)

@property (nonatomic, assign) speedLevel level;

@end
