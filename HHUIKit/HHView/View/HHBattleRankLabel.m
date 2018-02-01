//
//  HHBattleRankLabel.m
//  FunnyTicket
//
//  Created by tasama on 17/8/17.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHBattleRankLabel.h"
#import <YYText.h>
#import "NSString+Size.h"

@implementation HHBattleRankLabel

- (void)setRankString:(NSString *)rankString {
    
    _rankString = rankString;
    
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:rankString];
    
    UIFont *fontTypeOne = [UIFont italicSystemFontOfSize:20.0f];
    UIFont *fontTypeTwo = [UIFont italicSystemFontOfSize:14.0f];
    
    [aString yy_setFont:fontTypeOne range:NSMakeRange(0, aString.string.length)];
    [aString yy_setColor:[UIColor whiteColor] range:NSMakeRange(0, aString.string.length)];
    [aString yy_setFont:fontTypeTwo range:NSMakeRange(0, 3)];
    [aString yy_setColor:[[UIColor whiteColor] colorWithAlphaComponent:.5f] range:NSMakeRange(0, 3)];
    
    self.attributedText = aString;
}

- (CGFloat)width {
    
    return self.rankString ? [self.rankString stringWidthWithFont:[UIFont italicSystemFontOfSize:20.0f] height:CGFLOAT_MAX] : 0.0f;
}

@end
