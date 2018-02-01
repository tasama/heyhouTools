//
//  HHSwaggerWindow.m
//  FunnyTicket
//
//  Created by tasama on 17/8/8.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHSwaggerWindow.h"
#import "HHSwaggerDateManager.h"
#import "SwaggerWindowView.h"

#import "HHUIConst.h"

@interface HHSwaggerWindow ()<SwaggerWindowViewDelegate>

@property (nonatomic, strong) SwaggerWindowView *contentView;

@end

@implementation HHSwaggerWindow

+ (instancetype)shared {
    
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    });
    
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
        self.rootViewController = [[UIViewController alloc] init];
        self.windowLevel = UIWindowLevelAlert;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
        self.contentView.frame = frame;
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)setCoverImage:(NSString *)coverImage {
    
    _coverImage = coverImage;
    
    self.contentView.coverUrl = coverImage;
}

- (void)show {
    
    if (!self.hidden) {
        
        return;
    }
    if ([HHSwaggerDateManager swaggerAlertShouldShow]) {
        
        self.alpha = 1.0f;
        self.hidden = NO;
        [self makeKeyWindow];
        [self bringSubviewToFront:self.contentView];
    }
}

- (void)hide {
    
    [UIView animateWithDuration:.3f animations:^{
        
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
       
        if (finished) {
            
            self.hidden = YES;
            [self resignKeyWindow];
            if ([self.myDelegate respondsToSelector:@selector(swaggerAdWindowDidDismiss:)]) {
                
                [self.myDelegate swaggerAdWindowDidDismiss:self];
            }
        }
    }];
}

#pragma mark - getter
- (SwaggerWindowView *)contentView {
    
    if (!_contentView) {
        
        _contentView = [SwaggerWindowView loadView];
        _contentView.myDelegate = self;
    }
    return _contentView;
}

#pragma mark - delegate
- (void)didClickedBtnAction:(SwaggerWindowView *)view {
    
    if ([self.myDelegate respondsToSelector:@selector(joinActionWithWindow:)]) {
        
        [self.myDelegate joinActionWithWindow:self];
    }
}

- (void)didClickCloseBtnAction:(SwaggerWindowView *)view {
    
    [self hide];
}

@end
