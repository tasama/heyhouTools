//
//  UIView+noDataView.h
//  FunnyTicket
//
//  Created by tasama on 17/4/25.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHNoDataView.h"

@interface UIView (noDataView)

#define defaultImage ImageNamed(@"Public_NoData")

- (void)showNoDataInViewWithPlaceholderImg:(UIImage *_Nullable)image InRect:(CGRect)rect andColor:(UIColor *_Nullable)color andMessage:(NSString *)message;

- (void)showNoDataInViewWithPlaceholderImg:(UIImage *_Nullable)image InRect:(CGRect)rect ImageY:(CGFloat)imageY andColor:(UIColor * _Nullable)color andMessage:(NSString *)message;

- (void)showNoDataInViewWithPlaceholderImg:(UIImage *_Nullable)image ImageY:(CGFloat)imageY andColor:(UIColor *_Nullable)color andMessage:(NSString *)message;

- (void)hideNoData;

@end
