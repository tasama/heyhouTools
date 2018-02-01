//
//  HHInteractiveTransition.m
//  TestPushAndPop
//
//  Created by tasama on 2017/7/23.
//  Copyright © 2017年 tasama. All rights reserved.
//

#import "HHInteractiveTransition.h"

@interface HHInteractiveTransition ()

@property (nonatomic, weak) UIViewController *vc;

@property (nonatomic, assign) BOOL state;

@end

@implementation HHInteractiveTransition

- (void)addPanGestureForViewController:(UIViewController *)viewController {
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    self.vc = viewController;
    [viewController.view addGestureRecognizer:pan];
}

- (void)handleGesture:(UIPanGestureRecognizer *)panGesture {
    
    CGFloat persent = 0;
    
    CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
    persent = transitionX / panGesture.view.frame.size.width;
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            //手势开始的时候标记手势状态，并开始相应的事件
            self.interation = YES;

            CGPoint transitionPoint = [panGesture translationInView:panGesture.view];
            
            if (transitionPoint.x >= 0) {
                
                _state = YES;
                if (self.popBlock) {
                    
                    self.popBlock();
                }
            } else {
                
                _state = NO;
                if (self.pushBlock) {
                    
                    self.pushBlock();
                }
            }
            break;
        case UIGestureRecognizerStateChanged:{
            //手势过程中，通过updateInteractiveTransition设置pop过程进行的百分比
            
            if (_state) {
                
                persent = persent < 0 ? 0 : persent;
            } else {
                
                persent = persent > 0 ? 0 : - persent;
            }
            [self updateInteractiveTransition:persent];
            break;
        }
        case UIGestureRecognizerStateEnded:{
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作
            self.interation = NO;
            if (fabs(persent) > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            break;
        }
            
        case UIGestureRecognizerStateCancelled: {
            
            [self finishInteractiveTransition];
            break;
        }
        default:
            break;
    }
}

@end
