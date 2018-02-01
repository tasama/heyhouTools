//
//  UIPickerView+Date.m
//  AFNetworkActivityLogger
//
//  Created by xheng on 9/11/17.
//

#import "UIPickerView+Date.h"

@implementation UIPickerView (Date)

+ (NSArray *)years
{
    NSMutableArray *years = @[].mutableCopy;
    for (int i = 0; i < 100; i++) {
        [years addObject:@(1950 + i)];
    }
    return years;
}

+ (NSArray *)months
{
    NSMutableArray *months = @[].mutableCopy;
    for (int i = 1; i < 13; i++) {
        [months addObject:@(i)];
    }
    return months;
}

+ (NSArray *)daysWithYear:(NSInteger)year Month:(NSInteger)month
{
    NSMutableArray *days = @[].mutableCopy;
    int dayNum = 0;
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            dayNum = 31;
            break;
        case 2:
        {
            if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
                dayNum = 29;
            }
            else
                dayNum = 28;
        }
            break;
        default:
            dayNum = 30;
            break;
    }
    for (int i = 0; i < dayNum; i++) {
        [days addObject:@(i + 1)];
    }
    return days;
}

@end
