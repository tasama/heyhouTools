//
//  LoadingAnimationView.m
//  calayerAnimation
//
//  Created by tasama on 17/12/12.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHVideoLoadingAnimationView.h"
#import "LoadingAnimationLayer.h"

@interface HHVideoLoadingAnimationView ()

@property (nonatomic, strong) LoadingAnimationLayer *loadIngLayer;

@property (nonatomic, assign, readwrite) BOOL isLoading;

@end

@implementation HHVideoLoadingAnimationView

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self.layer addSublayer:self.loadIngLayer];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.loadIngLayer.frame = self.bounds;
}

- (void)startAnimation {
    
    [self.loadIngLayer setHidden:NO];
    self.loadIngLayer.progress = 0; // end status
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progress"];
    animation.duration = 5;
    animation.fromValue = @0.0f;
    animation.toValue = @2.0f;
    animation.repeatCount = CGFLOAT_MAX;
    [self.loadIngLayer addAnimation:animation forKey:nil];
    self.isLoading = YES;
}

- (void)endAnimation {
    
    [self.loadIngLayer removeAllAnimations];
    [self.loadIngLayer setHidden:YES];
    self.isLoading = NO;
}

- (LoadingAnimationLayer *)loadIngLayer {
    
    if (!_loadIngLayer) {
        
        _loadIngLayer = [LoadingAnimationLayer layer];
     }
    return _loadIngLayer;
}

@end
