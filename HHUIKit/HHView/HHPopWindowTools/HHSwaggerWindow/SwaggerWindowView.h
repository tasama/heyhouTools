//
//  SwaggerWindowView.h
//  FunnyTicket
//
//  Created by tasama on 17/8/8.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwaggerWindowView;
@protocol SwaggerWindowViewDelegate <NSObject>

- (void)didClickedBtnAction:(SwaggerWindowView *)view;

- (void)didClickCloseBtnAction:(SwaggerWindowView *)view;

@end
@interface SwaggerWindowView : UIView

@property (nonatomic, weak) id <SwaggerWindowViewDelegate> myDelegate;

@property (nonatomic, copy) NSString *coverUrl;

+ (instancetype)loadView;

@end
