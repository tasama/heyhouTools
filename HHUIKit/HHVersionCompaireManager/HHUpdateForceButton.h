//
//  HHUpdateForceButton.h
//  FunnyTicket
//
//  Created by tasama on 17/5/31.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHUpdateForceButton : UIView

@property (nonatomic, strong) UILabel *btnLabel;

@property (nonatomic, strong) UIButton *backImageView;

- (void)addTarget:(id)target WithAction:(SEL)action;

@end
