//
//  HHPublicCommentView.h
//  FunnyTicket
//
//  Created by XiaoZefeng on 8/5/17.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HHPublicCommentViewDelegate <NSObject>

- (void)publicCommentViewSendMessage:(NSString *)text;

@end

@interface HHPublicCommentView : UIView

@property (nonatomic, assign) NSInteger maxInputCount;//最多输入字符,默认140

@property (nonatomic, copy) NSString *placeholdeString;

@property (nonatomic, weak) id <HHPublicCommentViewDelegate> delegate;

- (void)clearText;

- (void)commentViewBecomeFirstResponder;

- (void)commentViewResignFirstResponder;

@end
