//
//  NSObject+JSON.m
//  AFNetworking
//
//  Created by xheng on 9/11/17.
//

#import "NSObject+JSON.h"

@implementation NSObject (JSON)

- (NSString *)hh_JSONString{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        return jsonString;
    }else{
        return nil;
    }
}

@end
