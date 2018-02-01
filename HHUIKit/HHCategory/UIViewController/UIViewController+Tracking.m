//
//  UIViewController.m
//  FunnyTicket
//
//  Created by 袁良 on 2017/6/12.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "UIViewController+Tracking.h"
#import <objc/runtime.h>
#import <HHFoundation/HHClickAction.h>
#import <UMMobClick/MobClick.h>


static NSMutableArray *trackingFilter;

@implementation UIViewController (Tracking)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        trackingFilter = [NSMutableArray arrayWithObjects:@"UICompatibilityInputViewController", @"UIKeyboardCandidateGridCollectionViewController", @"_UIRemoteInputViewController", @"HHNavigationController", @"HHTabBarViewController", nil];
        [UIViewController exchangeImp:@selector(viewDidAppear:) with:@selector(hh_viewDidAppear:)];
        [UIViewController exchangeImp:@selector(viewDidDisappear:) with:@selector(hh_viewDidDisappear:)];
    });
}

+ (void)exchangeImp:(SEL)oldSel with:(SEL)newSel
{
    Class class = [self class];
    // When swizzling a class method, use the following:
    // Class class = object_getClass((id)self);
    
    SEL originalSelector = oldSel;
    SEL swizzledSelector = newSel;
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (BOOL)needTrack:(NSString *)className
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@", className];
    NSArray *results = [trackingFilter filteredArrayUsingPredicate:predicate];
    
    return results.count == 0;
}

#pragma mark - Method Swizzling

- (void)hh_viewDidAppear:(BOOL)animated {
    [self hh_viewDidAppear:animated];
    
    if (![UIViewController needTrack:NSStringFromClass([self class])]) return;
    
    [MobClick beginLogPageView:NSStringFromClass([self class])];
    [HHClickAction event:@"page.enter" andObject:@{@"id" : NSStringFromClass([self class])}];
}

- (void)hh_viewDidDisappear:(BOOL)animated {
    [self hh_viewDidDisappear:animated];
    
    if (![UIViewController needTrack:NSStringFromClass([self class])]) return;
    
    [MobClick endLogPageView:NSStringFromClass([self class])];
    [HHClickAction event:@"page.exit" andObject:@{@"id" : NSStringFromClass([self class])}];
}

@end
