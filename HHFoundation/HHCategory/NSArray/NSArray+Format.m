//
//  NSArray+Format.m
//  FunnyTicket
//
//  Created by Xiayulin on 16/12/17.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "NSArray+Format.h"

#import <objc/runtime.h>

@implementation NSArray (Format)

/*
 *   传递一个model实体
 *   @param model 实体
 *   @return  实体属性
 */

+ (NSArray *)getAllproperties:(id)model{
    
    u_int count;
    
    objc_property_t *properties = class_copyPropertyList([model class], &count);
    
    //定义一个可变的属性数组
    
    NSMutableArray *propertiesArray = [NSMutableArray array];
    
    for (int i =0;i<count; i++)
    {
        
        const char *propertyName = property_getName(properties[i]);
        
        [propertiesArray addObject:[NSString stringWithUTF8String:propertyName]];
    }
    
    return propertiesArray;
}

@end
