//
//  UIAlertView+Block.h
//  FunnyTicket
//
//  Created by 袁良 on 2017/3/15.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#ifndef UIAlertView_Block_h
#define UIAlertView_Block_h

#import <UIKit/UIKit.h>
typedef void(^CompleteBlock) (NSInteger buttonIndex);

@interface UIAlertView (Block)

// 用Block的方式回调，这时候会默认用self作为Delegate
- (void)showAlertViewWithCompleteBlock:(CompleteBlock) block;

@end


#endif /* UIAlertView_Block_h */
