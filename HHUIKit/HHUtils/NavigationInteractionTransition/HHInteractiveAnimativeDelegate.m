//
//  HHInteractiveAnimativeDelegate.m
//  TestPushAndPop
//
//  Created by tasama on 2017/7/23.
//  Copyright © 2017年 tasama. All rights reserved.
//

#import "HHInteractiveAnimativeDelegate.h"
#import "UIView+frame.h"

@interface HHInteractiveAnimativeDelegate ()

@property (nonatomic, assign, getter=isPopInitialized) BOOL popInitialized;

@end

@implementation HHInteractiveAnimativeDelegate

- (instancetype)initWithTransitionType:(TranslationAnimationType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return .3f;
}

/**
 *  如何执行过渡动画
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_type) {
        case TranslationAnimationTypePush:
            [self doPushAnimation:transitionContext];
            break;
            
        case TranslationAnimationTypePop:
            [self doPopAnimation:transitionContext];
            break;
    }
}

- (void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    toVC.view.zf_left = toVC.view.zf_width;
    
    toVC.view.layer.shadowOffset = CGSizeMake(- 5, 0);
    toVC.view.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:.18f].CGColor;
    toVC.view.layer.shadowOpacity = .8f;
    
    [[transitionContext containerView] addSubview:toVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        fromVC.view.zf_left = - fromVC.view.zf_width / 2.0f;
        toVC.view.zf_left = 0;
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
        if (![transitionContext transitionWasCancelled]) {
            
            fromVC.navigationController.delegate = nil;
            [fromVC.view removeFromSuperview];
        }
    }];
}

- (void)doPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    toVC.view.zf_left = - toVC.view.zf_width / 2.0f;
    
    [[transitionContext containerView] insertSubview:toVC.view atIndex:0];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        fromVC.view.zf_left = fromVC.view.zf_width;
        toVC.view.zf_left = 0;
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if (![transitionContext transitionWasCancelled]) {
            
            fromVC.navigationController.delegate = nil;
            [fromVC.view removeFromSuperview];
        }
    }];
}


@end
