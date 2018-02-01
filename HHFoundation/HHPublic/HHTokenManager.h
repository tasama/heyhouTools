//
//  HHTokenManager.h
//  AFNetworking
//
//  Created by xheng on 9/11/17.
//

#import <Foundation/Foundation.h>

@interface HHTokenManager : NSObject

/**
 设置token
 */
+(void)setToken:(NSString *)token;

+ (NSString *)getToken;
/**
 设置Uid
 */
+(void)setUid:(NSString *)uid;

+ (NSString *)getUid;

+ (BOOL)isLogin;

@end
