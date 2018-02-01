//
//  HHXGBindTagTool.h
//  FunnyTicket
//
//  Created by tasama on 17/10/27.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <Foundation/Foundation.h>

//版本标签标示
static NSString *const VersionTag = @"heyhou_versionTag-";

@interface HHXGBindTagTool : NSObject

+ (void)bindNewTagWithTagIdentifier:(NSString *)identifier withTagType:(NSString *)tagType;

+ (void)bindNewAccountIdentifier:(NSString *)identifier;

+ (void)unBindAccountWith:(NSString *)identifier;

+ (void)unBindAllAccount;

@end
