//
//  UIView+HUD.m
//  AFNetworking
//
//  Created by xheng on 3/11/17.
//

#import "UIView+HUD.h"
#import "MBProgressHUD.h"

@implementation UIView (HUD)
    
static MBProgressHUD *RHHUD;
    
+ (void)showHudInView:(UIView *)view hint:(NSString *)hint {
    
    if (!RHHUD) {
        
        RHHUD = [[MBProgressHUD alloc] initWithView:view];
    }
    RHHUD.label.text = hint;
    [view addSubview:RHHUD];
    [RHHUD showAnimated:YES];
}
    
+ (void)hideHud {
    
    [RHHUD hideAnimated:YES];
}

@end
