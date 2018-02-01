//
//  LoadingAnimationView.h
//  calayerAnimation
//
//  Created by tasama on 17/12/12.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHVideoLoadingAnimationView : UIView

@property (nonatomic, assign, readonly) BOOL isLoading;

- (void)startAnimation;

- (void)endAnimation;

@end
