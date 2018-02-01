//
//  HHRapBattleLikeBtn.m
//  FunnyTicket
//
//  Created by tasama on 17/8/17.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHRapBattleLikeBtn.h"
#import "UIColor+Hex.h"
#import "UIView+Frame.h"
@interface HHRapBattleLikeBtn ()

@end

@implementation HHRapBattleLikeBtn

+ (instancetype)btnWithLikeNum:(NSInteger)num withBtnType:(HHRapBattleLikeBtnType)rapType {
    
    HHRapBattleLikeBtn *battleBtn = [HHRapBattleLikeBtn buttonWithType:UIButtonTypeCustom];
    
    battleBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    
    [battleBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    
    if (num > 0) {
        
        if (num > 9999) {
            
            [battleBtn setTitle:[NSString stringWithFormat:@"%.2f万", num / 10000] forState:UIControlStateNormal];
        } else {
            
            [battleBtn setTitle:[NSString stringWithFormat:@"%zd", num] forState:UIControlStateNormal];
        }
    } else {
        
        [battleBtn setTitle:@"" forState:UIControlStateNormal];
    }
    [battleBtn setImage:[UIImage imageNamed:@"Rap_btn_love_nor"] forState:UIControlStateNormal];
    
    battleBtn.btnType = rapType;
    
    return battleBtn;
}

+ (instancetype)btnWithCommentNum:(NSUInteger)num withBtnType:(HHRapBattleLikeBtnType)rapType {
    
    HHRapBattleLikeBtn *battleBtn = [HHRapBattleLikeBtn buttonWithType:UIButtonTypeCustom];
    
    battleBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    
    [battleBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    
    if (num > 0) {
        
        if (num > 9999) {
            
            [battleBtn setTitle:[NSString stringWithFormat:@"%.2f万", num / 10000] forState:UIControlStateNormal];
        } else {
            
            [battleBtn setTitle:[NSString stringWithFormat:@"%zd", num] forState:UIControlStateNormal];
        }
    } else {
        
        [battleBtn setTitle:@"" forState:UIControlStateNormal];
    }
    [battleBtn setImage:[UIImage imageNamed:@"Rap_btn_mes_nor"] forState:UIControlStateNormal];
    
    battleBtn.btnType = rapType;
    
    return battleBtn;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat titleWidth = self.titleLabel.zf_width;
    CGFloat imageViewWidth = self.imageView.zf_width;
    CGFloat margin = 6.0f;
    CGFloat leftMargin = (self.zf_width - titleWidth - imageViewWidth - margin) / 2.0f;
    if (_btnType == HHRapBattleLikeBtnTypeLeft) {
        
        self.imageView.zf_left = leftMargin;
        self.titleLabel.zf_left = self.imageView.zf_right + margin;
        
    } else if (_btnType == HHRapBattleLikeBtnTypeRight) {
        
        self.titleLabel.zf_left = leftMargin;
        self.imageView.zf_left = self.titleLabel.zf_right + margin;
        
    } else if (_btnType == HHRapBattleLikeBtnTypeBottom) {
        
        self.imageView.zf_left = (self.zf_width - self.imageView.zf_width) / 2.0f;
        CGFloat totalHeight = self.imageView.zf_height + 13.0f + 7.0f;
        self.imageView.zf_top = (self.zf_height - totalHeight) / 2.0f;
        self.titleLabel.zf_top = self.imageView.zf_bottom + 7.0f;
        self.titleLabel.zf_left = 0;
        self.titleLabel.zf_width = self.zf_width;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
}

- (void)setBtnType:(HHRapBattleLikeBtnType)btnType {
    
    _btnType = btnType;
    
    [self layoutIfNeeded];
}

@end
