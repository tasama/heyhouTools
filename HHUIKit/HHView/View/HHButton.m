//
//  HHButton.m
//  FunnyTicket
//
//  Created by tasama on 16/10/17.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "HHButton.h"

@implementation HHButton

+ (instancetype)initWithTitle:(NSString *)titleString andTitleColor:(UIColor *)color andTitleFont:(UIFont *)font andRed:(CGFloat)redius {
    
    HHButton *btn = [[self alloc]init];
    
    btn.titleLabel.numberOfLines = 0;
    
    [btn setTitle:titleString forState:UIControlStateNormal];
    
    [btn setTitleColor:color forState:UIControlStateNormal];
    
    btn.titleLabel.font = font;
    
    btn.layer.borderColor = color.CGColor;
    
    btn.layer.borderWidth = .5f;
    
    btn.layer.cornerRadius = redius;
    
    btn.layer.masksToBounds = YES;
    
    btn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    
    return btn;
}

- (void)dealloc {
    
    [self removeObserver:self forKeyPath:@"state"];
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"state"]) {
        
        UIControlState state = [change[@"new"] integerValue];
        if (state == UIControlStateNormal) {
            
        }
    }
}

- (void)setEdg:(UIEdgeInsets)edg {
    
    self.contentEdgeInsets = edg;
}
@end
