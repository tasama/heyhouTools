//
//  HHTools+Alert.m
//  AFNetworking
//
//  Created by xheng on 6/11/17.
//

#import "HHAlert.h"
#import "CapionView.h"
#import <HHFoundation/HHMarco.h>

@implementation HHAlert

+ (void)showAlertString:(NSString *)string
{
    if (kStringIsEmpty(string)) {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[CapionView shareManager] showText:string];
    });
}

+ (void)showAlertStringInCenter:(NSString *)string
{
    if (kStringIsEmpty(string)) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
         [[CapionView shareManager] showTextInCenter:string];
    });
}
+ (void)showAlertTitle:(NSString *)title andSubString:(NSString *)subString {
    
   dispatch_async(dispatch_get_main_queue(), ^{
        [[CapionView shareManager] showTextTitle:title andSubString:subString];
    });
}
@end
