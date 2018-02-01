//
//  HHBaseModel.h
//  FunnyTicket
//
//  Created by Xiayulin on 16/12/17.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHBaseModel : NSObject

/*
 *   父类的init方法
 */
- (id)initWithJson:(id)obj;

/*
 *  供子类调用
 */
- (void)dataChangeWithObject:(id)obj;

@end
