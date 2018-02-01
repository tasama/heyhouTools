//
//  HHHookInit.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 10/11/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "HHHookInit.h"
#import "UIWebView+HHPrivate.h"
#import "UIImageView+AdaptiveImage.h"

@implementation HHHookInit

+ (void)webViewHook {
    [UIWebView hookProcess];
}

+ (void)SDWebImageHook {
    [UIImageView hookSDWebImage];
}

@end
