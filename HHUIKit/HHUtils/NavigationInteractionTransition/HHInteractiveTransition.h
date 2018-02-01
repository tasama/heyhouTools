//
//  HHInteractiveTransition.h
//  TestPushAndPop
//
//  Created by tasama on 2017/7/23.
//  Copyright © 2017年 tasama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interation;

@property (nonatomic, copy) void (^pushBlock)();

@property (nonatomic, copy) void (^popBlock)();

- (void)addPanGestureForViewController:(UIViewController *)viewController;

@end
