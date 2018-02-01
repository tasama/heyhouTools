//
//  HHRequestSignTool.h
//  FunnyTicket
//
//  Created by tasama on 17/10/26.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHRequestSignTool : NSObject


/**
 对参数加上签名

 @param parameters 参数列表

 @return 返回新参数
 */
+ (NSDictionary *)signRequestWithParameters:(NSDictionary *)parameters;

/**
 对参数加上签名
 
 @param parameters 参数列表
 
 @return 返回新参数
 */
+ (NSString *)getParamsSignedMD5:(NSString *)parameters;

@end
