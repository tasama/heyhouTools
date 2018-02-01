//
//  HHAtFriendLabel.m
//  FunnyTicket
//
//  Created by tasama on 17/6/22.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHAtFriendLabel.h"
#import "UILabel+YBAttributeTextTapAction.h"

@interface HHAtFriendLabel () <YBAttributeTapActionDelegate>

@end

@implementation HHAtFriendLabel

- (void)setTitleText:(NSString *)titleText {
    
    NSArray *textArray = [titleText componentsSeparatedByString:@"@"];
    if (textArray.count > 1) {
        
        NSMutableArray *rangeArray = @[].mutableCopy;
        NSMutableArray *nameArray = @[].mutableCopy;
        for (int i = 1; i < textArray.count; i ++) {
            
            NSString *friendName = textArray[i];
            friendName = [@"@" stringByAppendingString:friendName];
            
            NSRange range = [friendName rangeOfString:@" "];
            
            if (range.location != NSNotFound) {
                
                friendName = [friendName substringToIndex:range.location];
            }
            [nameArray addObject:friendName];
            NSRange nameRange = [titleText rangeOfString:friendName];
            [rangeArray addObject:[NSValue valueWithRange:nameRange]];
        }
        NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:titleText];
        for (NSValue *nameRangeValue in rangeArray) {
            
            NSRange nameRange = [nameRangeValue rangeValue];
            [attributedTitle setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f weight:UIFontWeightBold]} range:nameRange];
        }
        self.attributedText = attributedTitle;
        [self yb_addAttributeTapActionWithStrings:nameArray.copy delegate:self];
        self.userInteractionEnabled = YES;
    } else {
        
        self.text = titleText;
        self.userInteractionEnabled = NO;
    }
}

- (void)yb_attributeTapReturnString:(NSString *)string range:(NSRange)range index:(NSInteger)index {
    
    if ([self.myDelegate respondsToSelector:@selector(friendLabel:attributeTapReturnString:)]) {
        
        [self.myDelegate friendLabel:self attributeTapReturnString:string];
    }
}

@end
