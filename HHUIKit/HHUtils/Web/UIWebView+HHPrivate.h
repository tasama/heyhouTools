//
//  UIWebView+HHPrivate.h
//  FunnyTicket
//
//  Created by XiaoZefeng on 10/11/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "HHHookProxy.h"

@interface UIWebView (HHPrivate)<HHHookProxy>

- (JSContext *)jsContext;

@end
