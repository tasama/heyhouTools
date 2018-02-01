//
//  HHTitleBtns.m
//  FunnyTicket
//
//  Created by tasama on 17/2/14.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import "HHTitleBtns.h"
#import "UIView+Frame.h"

@interface HHTitleBtns ()

@property (nonatomic, strong) UIView *redPoint;

@end

@implementation HHTitleBtns

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.redPoint];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.redPoint.frame = CGRectMake(self.titleLabel.zf_right - 3, self.titleLabel.zf_top - 3, 6, 6);
}

- (void)showRedPoint {
    
    self.redPoint.hidden = NO;
}

- (void)hideRedPoint {
    
    self.redPoint.hidden = YES;
}

#pragma mark - 懒加载
- (UIView *)redPoint
{
    if (!_redPoint) {
        _redPoint = [[UIView alloc]init];
        _redPoint.layer.cornerRadius = 3;
        _redPoint.layer.masksToBounds = YES;
        _redPoint.backgroundColor = [UIColor redColor];
        _redPoint.hidden = YES;
    }
    
    return _redPoint;
}



@end
