//
//  HHInteractiveAnimativeDelegate.h
//  TestPushAndPop
//
//  Created by tasama on 2017/7/23.
//  Copyright © 2017年 tasama. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TranslationAnimationType) {
    TranslationAnimationTypePush = 0,
    TranslationAnimationTypePop
};

@interface HHInteractiveAnimativeDelegate : NSObject <UIViewControllerAnimatedTransitioning>

/**
 *  动画过渡代理管理的是push还是pop
 */
@property (nonatomic, assign) TranslationAnimationType type;
/**
 *  初始化动画过渡代理
 * @prama type 初始化pop还是push的代理
 */
+ (instancetype)transitionWithType:(TranslationAnimationType)type;
- (instancetype)initWithTransitionType:(TranslationAnimationType)type;

@end
