//
//  NSDictionary+unitTurn.m
//  FunnyTicket
//
//  Created by tasama on 17/2/20.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import "NSDictionary+unitTurn.h"

@implementation NSDictionary (unitTurn)

- (NSString *)unitTurnDes {
    
    if (![self count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[self description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}


@end
