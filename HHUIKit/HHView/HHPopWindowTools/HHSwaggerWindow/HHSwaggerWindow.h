//
//  HHSwaggerWindow.h
//  FunnyTicket
//
//  Created by tasama on 17/8/8.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHSwaggerWindow;
@protocol HHSwaggerWindowDelegate <NSObject>

- (void)joinActionWithWindow:(HHSwaggerWindow *)window;

- (void)swaggerAdWindowDidDismiss:(HHSwaggerWindow *)window;

@end

@interface HHSwaggerWindow : UIWindow

@property (nonatomic, weak) id <HHSwaggerWindowDelegate> myDelegate;

@property (nonatomic, copy) NSString *coverImage;

+ (instancetype)shared;

- (void)show;

- (void)hide;

@end
