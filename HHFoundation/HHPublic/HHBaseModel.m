//
//  HHBaseModel.m
//  FunnyTicket
//
//  Created by Xiayulin on 16/12/17.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "HHBaseModel.h"
//#import <objc/runtime.h>
@implementation HHBaseModel

- (id)initWithJson:(id)obj{
    if (self = [super init]) {
        //通过kvc 获取字典里的值,将key作为属性,将value作参数
        [self setValuesForKeysWithDictionary:obj];
    }
    return self;
}

/*
 *  供子类调用
 */
- (void)dataChangeWithObject:(id)obj{
    
    [self setValuesForKeysWithDictionary:obj];
}

/*
 *防止找不到key时崩溃
 *  1,防止服务器擅自加字段而又未通知我们产生的程序崩溃
 *  2,防止出现一些OC中不能声明的字段名
 */

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"Id"];
    }else{
     //   NSLog(@"未定义的key值为%@",key);
    }
    
}
//如果找不到key 直接返回
- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

//防止服务器和model的数据类型不符合的崩溃
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([value isKindOfClass:[NSNumber class]]) {
        [self setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
        
    }else if ([value isKindOfClass:[NSNull class]]){
        [self setValue:@"" forKey:key];
    }else
    {
        [super setValue:value forKey:key];
    }

}
/*
 *  这个方法coredata 缓存时专用 (不然会奔溃)
 */

- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues{
    //遍历字典
    for (NSString *key in keyedValues) {
        [self setValue:keyedValues[key] forKey:key];
    }
    
}

- (void)dealloc{
   // HHLogDebug(@"模型%@被销毁",self);
}

@end
