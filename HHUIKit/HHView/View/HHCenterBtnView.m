//
//  HHCenterBtnView.m
//  CenterAnimation
//
//  Created by tasama on 17/8/17.
//  Copyright © 2017年 tasama. All rights reserved.
//

#import "HHCenterBtnView.h"

@interface HHCenterBtnView ()<CenterBubbleDelegate>

@property (nonatomic, strong) UIImageView *centerImageView;

@property (nonatomic, strong) CenterBubble *centerBubble;

@end

@implementation HHCenterBtnView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.centerBubble];
        [self addSubview:self.centerImageView];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    [super willMoveToSuperview:newSuperview];
    
    self.centerBubble.frame = CGRectMake(0, 0, 54.0f, 54.0f);
    self.centerImageView.frame = CGRectMake(15.0f, 15.0f, 24.0f, 24.0f);
}

#pragma mark - getter
- (UIImageView *)centerImageView {
    
    if (!_centerImageView) {
        
        _centerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Oval 2"]];
        _centerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _centerImageView.clipsToBounds = YES;
    }
    return _centerImageView;
}

- (CenterBubble *)centerBubble {
    
    if (!_centerBubble) {
        
        _centerBubble = [[CenterBubble alloc] init];
        _centerBubble.delegate = self;
    }
    return _centerBubble;
}

- (void)didSelected:(BOOL)didSelected withPosition:(CenterBubblrPos)pos {
    
    if ([self.delegate respondsToSelector:@selector(didSelected:withPosition:)]) {
        
        [self.delegate didSelected:didSelected withPosition:pos];
    }
}

- (void)didTaped {
    
    if ([self.delegate respondsToSelector:@selector(didTaped)]) {
        
        [self.delegate didTaped];
    }
}

@end
