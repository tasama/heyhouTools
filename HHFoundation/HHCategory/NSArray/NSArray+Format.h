//
//  NSArray+Format.h
//  FunnyTicket
//
//  Created by Xiayulin on 16/12/17.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Format)

/*
 *   传递一个model实体
 *   @param model 实体
 *   @return  实体属性
 */

+ (NSArray *)getAllproperties:(id)model;

@end
