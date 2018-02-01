//
//  HHMidBtn.h
//  FunnyTicket
//
//  Created by tasama on 17/9/6.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CenterBubble.h"

@protocol HHMidBtnDelegate <NSObject>

- (void)didSelectedPosit:(CenterBubblrPos)pos;

@end

@interface HHMidBtn : UIView

@property (nonatomic, weak) id <HHMidBtnDelegate> delegate;

- (void)showAnimation;

- (void)hideWithFinished:(void(^)())finished;

@end
