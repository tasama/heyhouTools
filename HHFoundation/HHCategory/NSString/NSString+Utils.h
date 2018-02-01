//
//  NSString+Utils.h
//  FunnyTicket
//
//  Created by heyhou on 17/1/18.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)
//判断银行卡
- (BOOL)checkCardNo;

/**
 判断是否是电话号码
 */
- (BOOL)numberIsLegal;

/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
- (NSMutableDictionary *)getURLParameters;

+ (NSString *)numberToString:(NSInteger)number;
@end
