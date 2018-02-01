//
//  \\      //     ||          ||     ||\        ||
//   \\    //      ||          ||     ||\\       ||
//    \\  //       ||          ||     || \\      ||
//     \\//        ||          ||     ||  \\     ||
//      /\         ||          ||     ||   \\    ||
//     //\\        ||          ||     ||    \\   ||
//    //  \\       ||          ||     ||     \\  ||
//   //    \\      ||          ||     ||      \\ ||
//  //      \\      \\        //      ||       \\||
// //        \\      \\======//       ||        \||
//
//
//  XUNModel.m
//  ProjectKit
//
//  Created by xun on 16/12/13.
//  Copyright © 2016年 Xun. All rights reserved.
//

#import "XUNModel.h"
#import <objc/runtime.h>

@implementation XUNModel

+ (id)objWithJsonObj:(id)jsonObj
{
    if ([jsonObj isKindOfClass:[NSArray class]])
    {
        return [self arrayFromJsonObj:jsonObj];
    }
    else if([jsonObj isKindOfClass:[NSDictionary class]])
    {
        return [self objectFromJsonObj:jsonObj];
    }
    else
        return jsonObj;
}

- (NSString *)jsonString
{
    id obj = nil;
    
    if ([self isKindOfClass:[NSArray class]] ||
        [self isKindOfClass:[NSSet class]])
    {
        obj = [self noModelArray];
    }
    else if ([obj isKindOfClass:[NSDictionary class]])
    {
        obj = [self noModelDictionary];
    }
    else if([obj isKindOfClass:[XUNModel class]])
    {
        obj = [self keysAndValues];
    } else {
        return nil;
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];

    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



- (NSDictionary *)keysAndValues
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    NSArray *propertyList = [self propertyList];
    
    for (NSString *key in propertyList)
    {
        id value = [self valueForKey:key];
        
        if (!value || [value isKindOfClass:[NSNull class]])
        {
            continue;
        }
        
        if ([value isKindOfClass:[NSSet class]] ||
            [value isKindOfClass:[NSArray class]])
        {
            dict[key] = [value noModelArray];
        }
        else if ([value isKindOfClass:[NSDictionary class]])
        {
            dict[key] = [value noModelDictionary];
        }
        else if ([dict[key] isKindOfClass:[XUNModel class]])
        {
            dict[key] = [value keysAndValues];
        }
        else
        {
            dict[key] = value;
        }
    }
    
    return dict;
}

- (id)noModelArray
{
    NSMutableArray *arr = [NSMutableArray array];
    
    NSArray *array = (id)self;
    
    for (id obj in array)
    {
        if ([obj isKindOfClass:[NSArray class]] ||
            [obj isKindOfClass:[NSSet class]])
        {
            [arr addObject:[obj noModelArray]];
        }
        else if ([self isKindOfClass:[NSDictionary class]])
        {
            [arr addObject:[obj noModelDictionary]];
        }
        else if ([obj isKindOfClass:[XUNModel class]])
        {
            [arr addObject:[obj keysAndValues]];
        }
    }
    
    return arr;
}

- (id)noModelDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)self];
    
    for (NSString *key in [dict allKeys])
    {
        id value = [self valueForKey:key];
        
        if (!value || [value isKindOfClass:[NSNull class]])
        {
            continue;
        }
        
        if ([value isKindOfClass:[NSSet class]] ||
            [value isKindOfClass:[NSArray class]])
        {
            dict[key] = [value noModelArray];
        }
        else if ([value isKindOfClass:[NSDictionary class]])
        {
            dict[key] = [value noModelDictionary];
        }
        else if ([dict[key] isKindOfClass:[XUNModel class]])
        {
            dict[key] = [value keysAndValues];
        }
    }
    
    return dict;
}

#pragma mark 获取对象属性列表

- (NSArray *)propertyList
{
    unsigned count = 0;
    
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableArray *propertyList = [NSMutableArray new];
    
    for (int i = 0; i < count; i++)
    {
        [propertyList addObject:[NSString stringWithUTF8String:property_getName(properties[i])]];
    }
    
    free(properties);
    
    return propertyList;
}

#pragma mark - Protocol

+ (NSDictionary *)classDict
{
    return nil;
}

+ (NSDictionary *)replaceDict
{
    return nil;
}

#pragma mark -- Private Method

+ (NSDictionary *)propertyAttributeDict
{
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList(self, &count);
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    for (int i = 0; i < count; i++)
    {
        NSString *str = [[NSString alloc] initWithUTF8String:property_getAttributes(properties[i])];
        
        NSArray *arr = [str componentsSeparatedByString:@","];
        
        NSString *propertyName = [arr.lastObject stringByReplacingOccurrencesOfString:@"V_" withString:@""];
        
        NSString *typeName = nil;
        
        if ([arr.firstObject containsString:@"@"])
        {
            typeName = [arr[0] stringByReplacingOccurrencesOfString:@"T@\"" withString:@""];
            typeName = [typeName stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        }
        else
        {
            typeName = [arr[0] stringByReplacingOccurrencesOfString:@"T" withString:@""];
        }
        
        dict[propertyName] = typeName;
    }
    
    return dict;
}

+ (NSArray *)arrayFromJsonObj:(NSArray *)jsonObj
{
    NSMutableArray *arr = [NSMutableArray array];
    
    for (id obj in jsonObj)
    {
        if ([obj isKindOfClass:[NSNull class]])
        {
            continue;
        }
        else if ([obj isKindOfClass:[NSArray class]])
        {
            [arr addObject:[self arrayFromJsonObj:obj]];
        }
        else if ([obj isKindOfClass:[NSDictionary class]])
        {
            [arr addObject:[self objectFromJsonObj:obj]];
        }
        else
        {
            [arr addObject:obj];
        }
    }
    return arr;
}

+ (instancetype)objectFromJsonObj:(NSDictionary *)jsonObj
{
    id obj = [self new];
    
    NSDictionary *propertyAttribute = [self propertyAttributeDict];
    
    for (NSString *key in [jsonObj allKeys])
    {
        NSString *property = [self replaceDict][key];
        
        if (!property || !property.length)
        {
            property = key;
        }
        id subObj = jsonObj[key];
        
        if([subObj isKindOfClass:[NSNull class]])
        {
            continue;
        }
        else if ([subObj isKindOfClass:[NSDictionary class]])
        {
            Class class = [self classDict][property];
            
            id value = [class objectFromJsonObj:subObj];
            
            [obj setValue:value forKey:property];
        }
        else if ([subObj isKindOfClass:[NSArray class]])
        {
            Class class = [self classDict][property];

            id value = [class arrayFromJsonObj:subObj];
            
            [obj setValue:value forKey:property];
        }
        else
        {
            if ([propertyAttribute[property] isEqualToString:@"NSString"])
            {
                [obj setValue:[NSString stringWithFormat:@"%@", subObj] forKey:property];
            }
            else if ([propertyAttribute[property] isEqualToString:@"c"])
            {
                [obj setValue:@([subObj boolValue]) forKey:property];
            }
            else if ([propertyAttribute[property] isEqualToString:@"i"] ||
                     [propertyAttribute[property] isEqualToString:@"S"] ||
                     [propertyAttribute[property] isEqualToString:@"s"])
            {
                [obj setValue:@([subObj intValue]) forKey:property];
            }
            else if ([propertyAttribute[property] isEqualToString:@"q"] ||
                     [propertyAttribute[property] isEqualToString:@"I"])
            {
                [obj setValue:@([subObj longLongValue]) forKey:property];
            }
            else
            {
                [obj setValue:subObj forKey:property];
            }
        }
    }
    
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

@end
