//
//  HHXGBindTagTool.m
//  FunnyTicket
//
//  Created by tasama on 17/10/27.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHXGBindTagTool.h"
#import "XGPush.h"

@implementation HHXGBindTagTool

+ (void)bindNewTagWithTagIdentifier:(NSString *)identifier withTagType:(NSString *)tagType {
    
    NSArray *identifiers = [[XGPushTokenManager defaultTokenManager] identifiersWithType:XGPushTokenBindTypeTag];
    BOOL hadBind = NO;
    for (NSString *ide in identifiers) {
        
        if ([ide hasPrefix:tagType]) {
            
            if (![ide isEqualToString:identifier]) {
                
                [[XGPushTokenManager defaultTokenManager] unbindWithIdentifer:ide type:XGPushTokenBindTypeTag];
            } else {
                
                hadBind = YES;
            }
        }
    }
    if (!hadBind) {
        
        [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:identifier type:XGPushTokenBindTypeTag];
    }
}

+ (void)bindNewAccountIdentifier:(NSString *)identifier {
    
    NSArray *accountIdentifiers = [[XGPushTokenManager defaultTokenManager] identifiersWithType:XGPushTokenBindTypeAccount];
    
    BOOL hadBindAccount = NO;
    for (NSString *accountIdentifier in accountIdentifiers) {
        
        if ([accountIdentifier isEqualToString:identifier]) {
            
            hadBindAccount = YES;
            break;
        }
    }
    if (!hadBindAccount) {
        
        [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:identifier type:XGPushTokenBindTypeAccount];
    }
}

+ (void)unBindAccountWith:(NSString *)identifier {
    
    NSArray *accountIdentifiers = [[XGPushTokenManager defaultTokenManager] identifiersWithType:XGPushTokenBindTypeAccount];
    
    BOOL hadBindAccount = NO;
    for (NSString *accountIdentifier in accountIdentifiers) {
        
        if ([accountIdentifier isEqualToString:identifier]) {
            
            hadBindAccount = YES;
        }
    }
    
    if (hadBindAccount) {
        
        [[XGPushTokenManager defaultTokenManager] unbindWithIdentifer:identifier type:XGPushTokenBindTypeAccount];
    }
}

+ (void)unBindAllAccount {
    
    NSArray *accountIdentifiers = [[XGPushTokenManager defaultTokenManager] identifiersWithType:XGPushTokenBindTypeAccount];
    for (NSString *accountIdentifier in accountIdentifiers) {
        
        [[XGPushTokenManager defaultTokenManager] unbindWithIdentifer:accountIdentifier type:XGPushTokenBindTypeAccount];
    }
}

@end
