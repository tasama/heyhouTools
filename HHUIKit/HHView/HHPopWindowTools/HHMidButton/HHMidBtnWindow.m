//
//  HHMidBtnWindow.m
//  FunnyTicket
//
//  Created by tasama on 17/9/6.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHMidBtnWindow.h"
#import "HHMidBtn.h"
#import "HHUIConst.h"

@interface HHMidBtnWindow ()<HHMidBtnDelegate>

@property (nonatomic, strong) HHMidBtn *midBtn;

@property (nonatomic, strong) UIImageView *centerImageView;

@end

@implementation HHMidBtnWindow

+ (instancetype)shared {
    
    static HHMidBtnWindow *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        [instance addSubview:instance.midBtn];
        [instance addSubview:instance.centerImageView];
    });
    
    return instance;
}

- (void)show {
    
    if (!self.hidden) {
        
        return;
    }
    self.alpha = 1.0f;
    self.hidden = NO;
    [self makeKeyWindow];
    [self.midBtn showAnimation];
//    [self bringSubviewToFront:self.contentView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self hide];
}

- (void)hide {
    
    [self.midBtn hideWithFinished:^{
        
        [UIView animateWithDuration:.3f animations:^{
            
            self.alpha = 0.0f;
        } completion:^(BOOL finished) {
            
            if (finished) {
                
                self.hidden = YES;
                [self resignKeyWindow];
            }
        }];
    }];
}

- (HHMidBtn *)midBtn
{
    if (!_midBtn) {
        _midBtn = [[HHMidBtn alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 54.0f) / 2.0f, SCREEN_HEIGHT - 49 - 11.0f, 54.0f, 54.0f)];
        _midBtn.delegate = self;
    }
    
    return _midBtn;
}

- (UIImageView *)centerImageView {
    
    if (!_centerImageView) {
        
        _centerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Oval 2"]];
        _centerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _centerImageView.clipsToBounds = YES;
        _centerImageView.frame = CGRectMake((SCREEN_WIDTH - 54.0f) / 2.0f + 15.0f, SCREEN_HEIGHT - 49 - 11.0f + 15.0f, 24.0f, 24.0f);
    }
    return _centerImageView;
}


- (void)didSelectedPosit:(CenterBubblrPos)pos {
    
    if ([self.delegate respondsToSelector:@selector(didSelectedPosit:)]) {
        
        [self.delegate didSelectedPosit:pos];
    }
    [self hide];
}
@end
