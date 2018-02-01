//
//  UIPickerView+Date.h
//  AFNetworkActivityLogger
//
//  Created by xheng on 9/11/17.
//

#import <UIKit/UIKit.h>

@interface UIPickerView (Date)

+ (NSArray *)years;

+ (NSArray *)months;

+ (NSArray *)daysWithYear:(NSInteger )year Month:(NSInteger )month;

@end
