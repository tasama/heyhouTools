//
//  LoadingAnimationLayer.m
//  calayerAnimation
//
//  Created by tasama on 17/12/12.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "LoadingAnimationLayer.h"
#import <UIKit/UIKit.h>

@interface LoadingAnimationLayer ()

@end

@implementation LoadingAnimationLayer

CGFloat kLineWidth = 4.0f;

- (void)drawInContext:(CGContextRef)ctx {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat radius = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) / 2.0f - kLineWidth / 2.0f;
    
    CGPoint center = CGPointMake(CGRectGetWidth(self.bounds) / 2.0f, CGRectGetHeight(self.bounds) / 2.0f);
    
    CGFloat startAngle = M_PI * 11 / 2.0f;
    CGFloat endAngle = M_PI * 5;
    if (_progress > 1) {
        
        CGFloat progress = _progress - 1;
        
        CGFloat A = 0;
        CGFloat B = 0;
        
        A = (4 - 5 / 2.0f * progress);
        B = (2.2 - 0.9f * progress);
        
        startAngle = A * M_PI;
        endAngle = B * M_PI;
        
    } else {
        
        CGFloat A = 0;
        CGFloat B = 0;
        
        A = (11 / 2.0f - 3 / 2.0f * _progress);
        B = (5.3 - 3.1f * _progress);
        
        startAngle = A * M_PI;
        endAngle = B * M_PI;

    }
    
    [path addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:NO];
    CGContextAddPath(ctx, path.CGPath);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineWidth(ctx, kLineWidth);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextStrokePath(ctx);
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    
    if ([key isEqualToString:@"progress"]) {
        
        return YES;
    }
    return [super needsDisplayForKey:key];
}

@end
