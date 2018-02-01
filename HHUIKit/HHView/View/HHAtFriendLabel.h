//
//  HHAtFriendLabel.h
//  FunnyTicket
//
//  Created by tasama on 17/6/22.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHAtFriendLabel;
@protocol HHAtFriendLabelDelegate <NSObject>

- (void)friendLabel:(HHAtFriendLabel *)friendLabel attributeTapReturnString:(NSString *)string;

@end

@interface HHAtFriendLabel : UILabel

- (void)setTitleText:(NSString *)titleText;

@property (nonatomic, weak) id <HHAtFriendLabelDelegate> myDelegate;

@end
