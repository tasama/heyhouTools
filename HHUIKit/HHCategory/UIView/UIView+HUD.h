//
//  UIView+HUD.h
//  AFNetworking
//
//  Created by xheng on 3/11/17.
//

#import <UIKit/UIKit.h>

@interface UIView (HUD)
    
+ (void)showHudInView:(UIView *)view hint:(NSString *)hint;
    
+ (void)hideHud;

@end
