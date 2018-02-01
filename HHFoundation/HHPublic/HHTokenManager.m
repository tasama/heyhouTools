//
//  HHTokenManager.m
//  AFNetworking
//
//  Created by xheng on 9/11/17.
//

#import "HHTokenManager.h"
#import "HHMarco.h"
#import "HHConst.h"

@implementation HHTokenManager


+(void)setUid:(NSString *)uid{
    
    [[NSUserDefaults standardUserDefaults] setObject:uid forKey:@"uid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if ([self isLogin]) {
        
        kIslogin(YES);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[NSNotificationCenter defaultCenter] postNotificationName:HHLoginSuccessNotification object:nil];
        });
    }
}

+ (NSString *)getUid{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
}

+ (NSString *)getToken
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
}

+(void)setToken:(NSString *)token{
    
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if ([self isLogin]) {
        
        kIslogin(YES);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[NSNotificationCenter defaultCenter] postNotificationName:HHLoginSuccessNotification object:nil];
        });
    }
}
+ (BOOL)isLogin
{
    if ([self getUid] && [self getToken]) {
        return YES;
    }
    return NO;
}


@end
