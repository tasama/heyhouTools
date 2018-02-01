//
//  HHCenterBtnView.h
//  CenterAnimation
//
//  Created by tasama on 17/8/17.
//  Copyright © 2017年 tasama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CenterBubble.h"

@protocol HHCenterBtnViewDelegate <NSObject>

- (void)didSelected:(BOOL)didSelected withPosition:(CenterBubblrPos)pos;

- (void)didTaped;

@end

@interface HHCenterBtnView : UIView

@property (nonatomic, weak) id <HHCenterBtnViewDelegate> delegate;

@end
