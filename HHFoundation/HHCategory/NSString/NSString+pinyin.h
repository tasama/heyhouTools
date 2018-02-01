//
//  NSString+pinyin.h
//  FunnyTicket
//
//  Created by tasama on 16/10/15.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (pinyin)

- (NSString *)firstCharactor;

- (NSString *)allFirstCharactor;

- (NSString *)allFirstSingleCharactor;

- (BOOL)isLetter;

- (BOOL)isPureInt;
@end
