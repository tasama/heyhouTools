//
//  NSString+JSON.m
//  AFNetworking
//
//  Created by xheng on 9/11/17.
//

#import "NSString+JSON.h"

@implementation NSString (JSON)

- (NSDictionary *)hh_jsonToDictionary
{
    if (self == nil) {
        return nil;
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
