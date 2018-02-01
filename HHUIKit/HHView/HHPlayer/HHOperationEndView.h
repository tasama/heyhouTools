//
//  HHOperationEndView.h
//  FunnyTicket
//
//  Created by XiaoZefeng on 2/8/17.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HHOperationEndViewDelegate <NSObject>

- (void)operationEndViewClickedBack:(UIButton *)btn;

- (void)operationEndViewClickedReplay:(UIButton *)btn;

- (void)operationEndViewClickedShare:(UIButton *)btn;

- (void)operationEndViewClickedMore:(UIButton *)btn;

@end

@interface HHOperationEndView : UIView

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, weak) id <HHOperationEndViewDelegate> delegate;

@property (nonatomic, strong) UIButton *moreButton;

@end
