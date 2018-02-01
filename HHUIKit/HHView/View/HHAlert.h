//
//  HHTools+Alert.h
//  AFNetworking
//
//  Created by xheng on 6/11/17.
//


@interface HHAlert: NSObject
+ (void)showAlertString:(NSString *)string;
+ (void)showAlertStringInCenter:(NSString *)string;
+ (void)showAlertTitle:(NSString *)title andSubString:(NSString *)subString;
@end
