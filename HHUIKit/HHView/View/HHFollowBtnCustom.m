//
//  HHFollowBtnCustom.m
//  FunnyTicket
//
//  Created by tasama on 17/7/19.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHFollowBtnCustom.h"

@interface HHFollowBtnCustom ()

@property (nonatomic, strong) UIColor *normalColor;

@property (nonatomic, strong) UIColor *selectColor;
@end

@implementation HHFollowBtnCustom

+ (instancetype)btnWithNormalColor:(UIColor *)normalColor andSelectedColor:(UIColor *)selectColor {

    HHFollowBtnCustom *btn = [[self alloc]init];
    
    btn.titleLabel.numberOfLines = 0;
    
    [btn setTitle:@"＋ 关注" forState:UIControlStateNormal];
    
    [btn setTitle:@"已关注" forState:UIControlStateSelected];
    
    [btn setTitleColor:normalColor forState:UIControlStateNormal];
    
    [btn setTitleColor:selectColor forState:UIControlStateSelected];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    
    btn.layer.borderColor = normalColor.CGColor;
    
    btn.layer.borderWidth = .5f;

    btn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    
    btn.normalColor = normalColor;
    
    btn.selectColor = selectColor;
    
    return btn;
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)dealloc {
    
    [self removeObserver:self forKeyPath:@"selected"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"selected"]) {
        
        BOOL state = [change[@"new"] integerValue];
        if (!state) {
            
            self.layer.borderColor = _normalColor.CGColor;
            
        } else {
            
            self.layer.borderColor = _selectColor.CGColor;
        }
    }
}

@end
