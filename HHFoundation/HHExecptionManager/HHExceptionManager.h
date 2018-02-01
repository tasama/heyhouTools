//
//  HHExceptionManager.h
//  CatchException
//
//  Created by tasama on 17/5/31.
//  Copyright © 2017年 tasama. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHExceptionManager : NSObject

+ (void)beginCatch;

+ (BOOL)isAppCrashedOnStartUpExceedTheLimit;

@end
