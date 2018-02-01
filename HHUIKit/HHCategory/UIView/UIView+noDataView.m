//
//  UIView+noDataView.m
//  FunnyTicket
//
//  Created by tasama on 17/4/25.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "UIView+noDataView.h"
#import <objc/runtime.h>
#import <HHMarco.h>

@implementation UIView (noDataView)

const char *tamsamaViewKey;
- (void)showNoDataInViewWithPlaceholderImg:(UIImage *)image InRect:(CGRect)rect andColor:(UIColor *)color andMessage:(NSString *)message {
    
    HHNoDataView *nodataView = (HHNoDataView *)[self getShowView];//[[HHNoDataView alloc] initWithFrame:rect];
    if (!nodataView) {
        
        nodataView = [[HHNoDataView alloc] initWithFrame:self.bounds];
        objc_setAssociatedObject(self, &tamsamaViewKey, nodataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if (nodataView.superview == self) {
        [nodataView removeFromSuperview];
    }
    nodataView.message = message;
    nodataView.image = image;
    
    
    if (rect.origin.y > 0) {
        
        nodataView.imageTop = rect.origin.y;
        [nodataView setNeedsDisplay];
    }
    
    [self addSubview:nodataView];
    
    if (!kObjectIsEmpty(color)) {
        
        nodataView.backgroundColor = color;
    } else {
        
        nodataView.backgroundColor = self.superview.backgroundColor;
    }
}

- (void)showNoDataInViewWithPlaceholderImg:(UIImage *)image ImageY:(CGFloat)imageY andColor:(UIColor *)color andMessage:(NSString *)message {
    
    HHNoDataView *nodataView = (HHNoDataView *)[self getShowView];//[[HHNoDataView alloc] initWithFrame:rect];
    if (!nodataView) {
        
        nodataView = [[HHNoDataView alloc] initWithFrame:self.bounds];
        objc_setAssociatedObject(self, &tamsamaViewKey, nodataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if (nodataView.superview == self) {
        [nodataView removeFromSuperview];
    }
    nodataView.message = message;
    nodataView.image = image;
    
    
    if (imageY > 0) {
        
        nodataView.imageTop = imageY;
        [nodataView setNeedsDisplay];
    }
    
    [self addSubview:nodataView];
    
    if (!kObjectIsEmpty(color)) {
        
        nodataView.backgroundColor = color;
    } else {
        
        nodataView.backgroundColor = self.superview.backgroundColor;
    }
}

- (void)showNoDataInViewWithPlaceholderImg:(UIImage *)image InRect:(CGRect)rect ImageY:(CGFloat)imageY andColor:(UIColor * _Nullable)color andMessage:(NSString *)message {
    
    HHNoDataView *nodataView = (HHNoDataView *)[self getShowView];//[[HHNoDataView alloc] initWithFrame:rect];
    if (!nodataView) {
        
        nodataView = [[HHNoDataView alloc] initWithFrame:rect];
        objc_setAssociatedObject(self, &tamsamaViewKey, nodataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if (nodataView.superview == self) {
        [nodataView removeFromSuperview];
    }
    nodataView.message = message;
    nodataView.image = image;
    
    if (imageY > 0) {
        
        nodataView.imageTop = imageY;
        [nodataView setNeedsDisplay];
    }
    
    [self addSubview:nodataView];
    
    if (!kObjectIsEmpty(color)) {
        
        nodataView.backgroundColor = color;
    } else {
        
        nodataView.backgroundColor = [UIColor clearColor];
    }
}

- (void)hideNoData {
    
    HHNoDataView *nodataView = (HHNoDataView *)[self getShowView];
    if (nodataView.superview == self) {
        [nodataView removeFromSuperview];
    }
}

- (HHNoDataView *)getShowView {
    
    return objc_getAssociatedObject(self, &tamsamaViewKey);
}

@end
