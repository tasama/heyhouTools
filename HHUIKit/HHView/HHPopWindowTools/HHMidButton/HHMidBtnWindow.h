//
//  HHMidBtnWindow.h
//  FunnyTicket
//
//  Created by tasama on 17/9/6.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CenterBubble.h"

@protocol HHMidBtnWindowDelegate <NSObject>

- (void)didSelectedPosit:(CenterBubblrPos)pos;

@end

@interface HHMidBtnWindow : UIWindow

@property (nonatomic, weak) id <HHMidBtnWindowDelegate> delegate;

+ (instancetype)shared;

- (void)show;

- (void)hide;

@end
