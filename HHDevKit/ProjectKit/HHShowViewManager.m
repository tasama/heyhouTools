//
//  HHShowViewManager.m
//  FunnyTicket
//
//  Created by Xun on 17/4/19.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHShowViewManager.h"
#import <objc/runtime.h>
#import <HHUIKit/HHUIKit.h>
#import "UIView+XUNFrame.h"

#define kShowViewManagerRemoveMaskNoti      @"SHOW_VIEW_MANAGER_REMOVE_MASK_NOTI"
#define kShowViewManagerMarkViewRemovedNoti @"SHOW_VIEW_MANAGER_MARK_VIEW_REMOVED_MOTI"
#define kShowViewManagerAssociateKey        @"SHOW_VIEW_MANAGER_ASSOCIATE_KEY"

@interface XUN_ShowView : UIView

@end

@implementation XUN_ShowView

- (instancetype)init {
    
    if (self = [super init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self.superview selector:@selector(removeFromSuperview) name:kShowViewManagerRemoveMaskNoti object:nil];
    }
    
    return self;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kShowViewManagerMarkViewRemovedNoti object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

@interface HHShowViewManager ()

@property (nonatomic, strong) UIView *mask;

@end

@implementation HHShowViewManager

#pragma mark - 单例

+ (instancetype)shareManager {
    
    return [[HHShowViewManager alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static HHShowViewManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[super allocWithZone:zone] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:manager selector:@selector(resetViewNil) name:kShowViewManagerMarkViewRemovedNoti object:nil];
    });
    return manager;
}

- (void)showView:(UIView *)view withAppearLocation:(HHViewAppearLocation)location {
    
    [self showView:view onView:[UIApplication sharedApplication].keyWindow appearLocation:location];
}

- (void)showView:(UIView *)view
          onView:(UIView *)superView
  appearLocation:(HHViewAppearLocation)location {
    
    if (location == HHViewAppearLocationTop) {
        
        view.zf_bottom = 0;
        view.zf_centerX = [UIScreen mainScreen].bounds.size.width / 2;
        
        [superView addSubview:view];
        
        [UIView animateWithDuration:0.25f animations:^{
            
            view.zf_top = 0;
        }];
        
        [UIView animateWithDuration:0.25 delay:3.f options:0 animations:^{
            
            view.zf_bottom = 0;
            
        } completion:^(BOOL finished) {
            
            if (finished) {
                
                [view removeFromSuperview];
            }
        }];
    }
    else if (location == HHViewAppearLocationCenter) {
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        
        [superView addSubview:self.mask];
        [superView addSubview:view];
        
        animation.duration = 0.1;
        animation.fromValue = @(1.05);
        animation.toValue = @(1);
        animation.beginTime = 0;
        animation.removedOnCompletion = YES;
        
        [view.layer addAnimation:animation forKey:nil];
        
        [view addSubview:[[XUN_ShowView alloc] init]];
    }
    else if (location == HHViewAppearLocationBottom) {

        view.centerX = SCREEN_WIDTH / 2;
        view.zf_top = SCREEN_HEIGHT;
        
        [superView addSubview:self.mask];
        [superView addSubview:view];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMask:)];
        [self.mask addGestureRecognizer:tap];
        
        [UIView animateWithDuration:0.25 animations:^{
            
            view.zf_top -= view.zf_height;
        }];

        [view addSubview:[[XUN_ShowView alloc] init]];

        objc_setAssociatedObject(self, kShowViewManagerAssociateKey, view, OBJC_ASSOCIATION_ASSIGN);
    }
}

#pragma mark - 底部视图专有

- (void)tapMask:(UITapGestureRecognizer *)tap {
    
    UIView *view = objc_getAssociatedObject(self, kShowViewManagerAssociateKey);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        view.zf_top = HHScreenHeight;
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            [self resetViewNil];
            
            [view removeFromSuperview];
        }
    }];
}

- (void)resetViewNil {
    
    [_mask removeFromSuperview];
    _mask = nil;
}

#pragma mark - Getter & Setter

- (UIView *)mask {
    
    if (!_mask) {
        
        _mask = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _mask.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return _mask;
}

@end
