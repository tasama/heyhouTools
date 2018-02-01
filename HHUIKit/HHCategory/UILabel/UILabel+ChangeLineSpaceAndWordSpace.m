//
//  UILabel+ChangeLineSpaceAndWordSpace.m
//  FunnyTicket
//
//  Created by tasama on 17/6/13.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "UILabel+ChangeLineSpaceAndWordSpace.h"

@implementation UILabel (ChangeLineSpaceAndWordSpace)

- (void)setText:(NSString *)text withLineSpace:(CGFloat)lineSpace {
    
    if (!text) {
        
        return;
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    self.attributedText = attributedString;
    self.lineBreakMode = NSLineBreakByTruncatingTail;
    [self sizeToFit];
}

@end
