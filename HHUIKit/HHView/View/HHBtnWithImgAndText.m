//
//  HHBtnWithImgAndText.m
//  FunnyTicket
//
//  Created by tasama on 17/4/12.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import "HHBtnWithImgAndText.h"
#import "UIView+Frame.h"
#import "NSString+Size.h"
@implementation HHBtnWithImgAndText

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //填写布局约束
    if (self.myContentType == HHBtnWithImgAndTextContentTypeLeft) {
        
        self.imageView.zf_left = 0;
    } else if (self.myContentType == HHBtnWithImgAndTextContentTypeRight) {
        
        CGFloat margin = (self.zf_width - self.imageView.zf_width - 5 - self.titleLabel.zf_width);
        self.imageView.zf_left = margin;

    } else if (self.myContentType == HHBtnWithImgAndTextContentTypeCenter) {
        
        CGFloat maring = (self.zf_width - self.imageView.zf_width - 5 - self.titleLabel.zf_width) / 2.0f;
        if (maring < 0) {
            
            maring = 0;
        }
        self.imageView.zf_left = maring;
    }
    self.titleLabel.zf_left = self.imageView.zf_right + 5;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
}

- (CGSize)getBtnSizeWithTitle:(NSString *)title andFont:(UIFont *)font {
    
    CGFloat height = [@"text" stringHeightWithFont:font width:CGFLOAT_MAX];
    CGFloat width = [title stringWidthWithFont:font height:height] + 20;
    
    return CGSizeMake(width, height);
}

- (CGSize)getBtnSizeWithNum:(NSInteger)num andFont:(UIFont *)font {
    
    NSString *numStr = @"";
    if (num > 99999) {
        
        numStr = [NSString stringWithFormat:@"%.1f万", num / 10000.0f];
    } else {
        
        numStr = [NSString stringWithFormat:@"%zd", num];
    }
    
    [self setTitle:numStr forState:UIControlStateNormal];
    self.titleLabel.font = font;
    
    return [self getBtnSizeWithTitle:numStr andFont:font];
}

- (CGSize)getBtnSizeWithNum:(NSInteger)num andFont:(UIFont *)font andPlaceHolder:(NSString *)placeholder {
    
    NSString *numStr = @"";
    if (num > 9999) {
        
        numStr = [NSString stringWithFormat:@"%.1f万", num / 10000.0f];
    } else {
        
        if (num > 0) {
            
            numStr = [NSString stringWithFormat:@"%zd", num];
        } else {
            
            numStr = placeholder;
        }
    }
    
    [self setTitle:numStr forState:UIControlStateNormal];
    self.titleLabel.font = font;
    
    return [self getBtnSizeWithTitle:numStr andFont:font];
}

@end
