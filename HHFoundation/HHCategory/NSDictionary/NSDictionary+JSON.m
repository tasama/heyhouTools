//
//  NSDictionary+JSON.m
//  AFNetworkActivityLogger
//
//  Created by xheng on 9/11/17.
//

#import "NSDictionary+JSON.h"
#import <HHMarco.h>

@implementation NSDictionary (JSON)

- (NSString *)hh_JSONString {
    if (kDictIsEmpty(self)) {
        return @"{}";
    }
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
