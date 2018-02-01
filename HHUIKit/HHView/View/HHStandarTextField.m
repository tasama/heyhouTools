//
//  HHStandarTextField.m
//  FunnyTicket
//
//  Created by Xun on 17/4/28.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHStandarTextField.h"
#import "NSString+AttributedString.h"
#import "UIColor+Hex.h"
#import "HHUIConst.h"


@implementation HHStandarTextField

- (void)setPlaceholder:(NSString *)placeholder {
    
    [super setPlaceholder:placeholder];
    
    if (_pColor) {
        
        [placeholder setColor:_pColor];
    }
    
    self.attributedPlaceholder = placeholder.xun_attributedText;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.layer.cornerRadius = 5.f;
        self.backgroundColor = HH_THEME_BACKGROUNDCOLOR;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    
    CGRect frame = rect;
    
    frame.origin.x = 8;
    frame.size.width = rect.size.width - 16;
    
    [super drawTextInRect:frame];
}

- (void)drawPlaceholderInRect:(CGRect)rect {
    
    CGRect frame = rect;
    
    frame.origin.x = 8;
    frame.size.width = rect.size.width - 16;
    
    [super drawPlaceholderInRect:frame];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    
    CGRect frame = bounds;
    
    frame.origin.x = 8;
    frame.size.width = bounds.size.width - 16;
    
    return frame;
}

@end
