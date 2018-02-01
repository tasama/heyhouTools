//
//  CenterBubble.m
//  CenterAnimation
//
//  Created by tasama on 17/8/15.
//  Copyright © 2017年 tasama. All rights reserved.
//

#import "CenterBubble.h"



@interface CenterBubble ()

@property (nonatomic, strong) UIView *blackCover;

@property (nonatomic, assign) CGPoint previousPoint;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, assign) BOOL moveCancel;

@end

@implementation CenterBubble

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor redColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
//        UILongPressGestureRecognizer *longPressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressesAction:)];
//        longPressGes.minimumPressDuration = .3f;
//        [self addGestureRecognizer:longPressGes];
        [self addSubview:self.blackCover];
        [self addSubview:self.iconImageView];
        self.previousPoint = CGPointZero;
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.layer.cornerRadius = self.bounds.size.width / 2.0f;
    self.layer.masksToBounds = YES;
    self.iconImageView.frame = self.bounds;
}

- (void)tapAction:(UITapGestureRecognizer *)gesture {
    
    if ([self.delegate respondsToSelector:@selector(didTaped)]) {
        
        [self.delegate didTaped];
    }
}

- (void)pressesAction:(UILongPressGestureRecognizer *)gesture {
    
    UIGestureRecognizerState state = gesture.state;
    
    switch (state) {
            
        case UIGestureRecognizerStateBegan: {
            
            self.moveCancel = NO;
            [UIView animateWithDuration:.25f animations:^{
                
                self.transform = CGAffineTransformMakeScale(3.0f, 3.0f);
                _blackCover.alpha = 1.0f;
            } completion:^(BOOL finished) {
                
                if (finished) {
                    
                    if (!self.moveCancel) {
                        
                        self.iconImageView.hidden = NO;
                    }
                }
            }];
            self.previousPoint = CGPointMake(0, self.bounds.size.height / 2.0f);
        }
            break;
            
        case UIGestureRecognizerStateChanged: {
            
            CGPoint point = [gesture locationInView:self];
            [self changeLocationWithPoint:point];
        }
            
            break;
            
        case UIGestureRecognizerStateEnded: {
            
            __weak typeof(self) weakSelf = self;
            self.moveCancel = YES;
            CGPoint point = [gesture locationInView:self];
            [self selfEndPressWithComplited:^(CenterBubblrPos pos) {
                
                self.iconImageView.hidden = YES;
                [UIView animateWithDuration:.25f animations:^{
                    
                    weakSelf.blackCover.alpha = 0.0f;
                    weakSelf.transform = CGAffineTransformIdentity;
                } completion:^(BOOL finished) {
                    
                    if (finished) {
                        
                        if ([weakSelf.delegate respondsToSelector:@selector(didSelected:withPosition:)]) {
                            
                            [weakSelf.delegate didSelected:[self.layer.presentationLayer containsPoint:point] withPosition:pos];
                        }
                    }
                }];
            }];
        }
            
            break;
            
        case UIGestureRecognizerStateCancelled: {
            
            __weak typeof(self) weakSelf = self;
            CGPoint point = [gesture locationInView:self];
            [self selfEndPressWithComplited:^(CenterBubblrPos pos) {
                
                self.iconImageView.hidden = YES;
                [UIView animateWithDuration:.25f animations:^{
                    
                    weakSelf.blackCover.alpha = 0.0f;
                    weakSelf.transform = CGAffineTransformIdentity;
                } completion:^(BOOL finished) {
                    
                    if (finished) {
                        
                        if ([weakSelf.delegate respondsToSelector:@selector(didSelected:withPosition:)]) {
                            
                            [weakSelf.delegate didSelected:[self.layer.presentationLayer containsPoint:point] withPosition:pos];
                        }
                    }
                }];
            }];
        }
            
            break;
            
        default:
            break;
    }
}

- (void)selfEndPressWithComplited:(void(^)(CenterBubblrPos))complited {
    
    CGAffineTransform transform = self.blackCover.transform;
    
    CGFloat rotate = acosf(transform.a);
    if (transform.b < 0) {
        rotate+= M_PI;
    }
    CGFloat degree = rotate / M_PI * 180;
    
    if (degree > 180.0f) {
        
        degree = degree - 180.0f;
    }

    if (degree < 67.5f) {
        
        [UIView animateWithDuration:.25f animations:^{
            
            self.blackCover.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
            if (finished && complited) {
                
                complited(CenterBubblrPosLeft);
            }
        }];
    } else {
        
        [UIView animateWithDuration:.25f animations:^{
            
            self.blackCover.transform = CGAffineTransformMakeRotation(M_PI - M_PI_4);
            
        } completion:^(BOOL finished) {
            
            if (finished && complited) {
                
                complited(CenterBubblrPosRight);
            }
        }];
    }
}

- (void)changeLocationWithPoint:(CGPoint)point {
    
    CGPoint center = CGPointMake(self.bounds.size.width / 2.0f, self.bounds.size.height / 2.0f);
    
    CGFloat angle = atan2f(point.y - center.y, point.x - center.x) - atan2f(self.previousPoint.y - center.y, self.previousPoint.x - center.x);
    
    self.blackCover.transform = CGAffineTransformMakeRotation(angle);//CGAffineTransformRotate(self.blackCover.transform, angle);
}

#pragma mark - getter
- (UIView *)blackCover {
    
    if (!_blackCover) {
        
        _blackCover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 54.0f, 54.0f)];
        _blackCover.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.5f];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:_blackCover.center];
        [path addLineToPoint:CGPointMake(0, 27.0f)];
        [path addArcWithCenter:_blackCover.center radius:_blackCover.bounds.size.width / 2.0f startAngle:M_PI endAngle:M_PI + M_PI_4 clockwise:YES];
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
