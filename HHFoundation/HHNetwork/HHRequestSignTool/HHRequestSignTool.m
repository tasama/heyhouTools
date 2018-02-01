//
//  HHRequestSignTool.m
//  FunnyTicket
//
//  Created by tasama on 17/10/26.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHRequestSignTool.h"
#import "NSString+MD5HexDigest.h"
#import "NSObject+JSON.h"
#import "NSString+JSON.h"
#import <Bugly/Bugly.h>
#define giftKey @"133e6826b8b5bbdb4c3a9f396f65b1e4" //礼物的MD5Key

@implementation HHRequestSignTool

+ (NSDictionary *)signRequestWithParameters:(NSDictionary *)parameters {
    
    NSMutableDictionary *newParameters = @{}.mutableCopy;
    
    [newParameters addEntriesFromDictionary:parameters];
    
    if (![parameters valueForKey:@"httpRequestTime"]) {
        
        [newParameters addEntriesFromDictionary:@{@"httpRequestTime":[NSString stringWithFormat:@"%.0lf", [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970]]}];
    }
    
    NSArray *newSortArray = [newParameters.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString   * _Nonnull obj1, NSString   * _Nonnull obj2) {
        
        NSRange range = NSMakeRange(0,MIN(obj1.length, obj2.length));
        
        return [obj1 compare:obj2 options:NSCaseInsensitiveSearch|NSNumericSearch|
         
         NSWidthInsensitiveSearch|NSForcedOrderingSearch range:range];
    }];
    
    NSMutableString *strSign = [NSMutableString string];
    
    for (int i = 0; i < newSortArray.count; i ++) {
        
        NSString *key = newSortArray[i];
        id value = newParameters[key];
        NSString *sign = [NSString stringWithFormat:@"%@", value];
        [strSign appendString:sign];
    }
    
    [strSign appendString:giftKey];
    
    if (strSign.length > 0) {
        
        [newParameters addEntriesFromDictionary:@{@"heyHouSign": [strSign.copy md5]}];
    }
    NSMutableDictionary *tempDic = @{@"parameters": parameters, @"newParameters": newParameters}.mutableCopy;
    [Bugly reportExceptionWithCategory:3 name:@"sign" reason:@"sign" callStack:@[] extraInfo:tempDic terminateApp:NO];
    return newParameters;
}

+ (NSString *)getParamsSignedMD5:(NSString *)parameters {
    
    NSDictionary *parameter = [parameters hh_jsonToDictionary];
    NSDictionary *newPar = [self signRequestWithParameters:parameter];
    return [[newPar hh_JSONString] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

@end
