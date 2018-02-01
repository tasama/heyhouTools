//
//  HHMidBtn.m
//  FunnyTicket
//
//  Created by tasama on 17/9/6.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHMidBtn.h"
#import "UIView+Frame.h"

@interface HHMidBtn ()

@property (nonatomic, strong) UIView *blackCover;

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation HHMidBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    //添加控件
    self.backgroundColor = [UIColor redColor];
    [self addSubview:self.blackCover];
    [self addSubview:self.iconImageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //填写布局约束
    self.layer.cornerRadius = self.bounds.size.width / 2.0f;
    self.layer.masksToBounds = YES;
    self.iconImageView.frame = self.bounds;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    
    CGFloat touchPointX = point.x * 3;
    CGFloat centerPointX = self.zf_width / 2.0f;
    
    if ([self.delegate respondsToSelector:@selector(didSelectedPosit:)]) {
        
        if (touchPointX < centerPointX) {
            
            [UIView animateWithDuration:.25f animations:^{
                
                self.blackCover.transform = CGAffineTransformMakeRotation(M_PI_4 - M_PI);
                
            } completion:^(BOOL finished) {
              
                if (finished) {
                    
                    [self.delegate didSelectedPosit:CenterBubblrPosLeft];
                }
            }];
        } else {
            
            [UIView animateWithDuration:.25f animations:^{
                
                self.blackCover.transform = CGAffineTransformIdentity;
                
            } completion:^(BOOL finished) {
                
                if (finished) {
                    
                    [self.delegate didSelectedPosit:CenterBubblrPosRight];
                }
            }];
        }
    }
}

- (void)showAnimation {
    
    [UIView animateWithDuration:.25f animations:^{
        
        self.transform = CGAffineTransformMakeScale(3.0f, 3.0f);
        _blackCover.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            self.iconImageView.hidden = NO;
        }
    }];
}

- (void)hideWithFinished:(void (^)())finishedBlock {
    
    [UIView animateWithDuration:.25f animations:^{
        
        self.blackCover.alpha = 0.0f;
        self.iconImageView.hidden = YES;
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            if (finishedBlock) {
                
                finishedBlock();
            }
        }
    }];
}

#pragma mark - getter
- (UIView *)blackCover {
    
    if (!_blackCover) {
        
        _blackCover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 54.0f, 54.0f)];
        _blackCover.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.5f];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:_blackCover.center];
        [path addLineToPoint:CGPointMake(54.0f, 27.0f)];
        [path addArcWithCenter:_blackCover.center radius:_blackCover.bounds.size.width / 2.0f startAngle:0 endAngle:- M_PI_4 clockwise:NO];
        [path addLineToPoint:_blackCover.center];
        CAShapeLayer *shapLayer = [CAShapeLayer layer];
        shapLayer.path = path.CGPath;
        _blackCover.layer.mask = shapLayer;
        _blackCover.alpha = 0.0f;
    }
    return _blackCover;
}

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_324"]];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.hidden = YES;
    }
    return _iconImageView;
}

@end
