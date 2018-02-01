//
//  NSString+selectedString.m
//  FunnyTicket
//
//  Created by tasama on 17/6/19.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "NSString+selectedString.h"

@implementation NSString (selectedString)

- (NSString *)selectedString {
    
    NSString *filterText = self;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^a-zA-Z0-9\u4e00-\u9fa5]" options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:filterText options:NSMatchingReportCompletion range:NSMakeRange(0, filterText.length) withTemplate:@""];
    return result;
}

@end
