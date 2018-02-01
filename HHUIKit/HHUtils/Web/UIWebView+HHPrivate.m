//
//  UIWebView+HHPrivate.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 10/11/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "UIWebView+HHPrivate.h"
#import <objc/runtime.h>

const char kJSContext;

@interface NSObject (PLPrivate) <UIWebViewDelegate>

@end

@implementation NSObject (PLPrivateHook)

- (void)privateHook_webViewDidFinishLoad:(UIWebView *)webView
{
    JSContext * context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    if (context)
    {
        objc_setAssociatedObject(webView, &kJSContext, context, OBJC_ASSOCIATION_RETAIN);
    }
    
    [self privateHook_webViewDidFinishLoad:webView];
}

@end

@implementation UIWebView (HHPrivate)

+ (void)hookProcess
{
    Method originMethod = class_getInstanceMethod(self, @selector(setDelegate:));
    Method hookMethod = class_getInstanceMethod(self, @selector(privateHook_setDelegate:));
    
    method_exchangeImplementations(originMethod, hookMethod);
}

- (void)privateHook_setDelegate:(id<UIWebViewDelegate>)delegate
{
    if (!objc_getAssociatedObject([self class], _cmd))
    {
        objc_setAssociatedObject([self class], _cmd, @"Hooked", OBJC_ASSOCIATION_RETAIN);
        
        //hook
        if (![delegate respondsToSelector:@selector(webViewDidFinishLoad:)])
        {
            class_addMethod([delegate class], @selector(webViewDidFinishLoad:), (IMP)webViewDidFinishLoad, "v@:@");
        }
        
        Method originMethod = class_getInstanceMethod([delegate class], @selector(webViewDidFinishLoad:));
        Method hookMethod = class_getInstanceMethod([delegate class], @selector(privateHook_webViewDidFinishLoad:));
        
        method_exchangeImplementations(originMethod, hookMethod);
    }
    
    [self privateHook_setDelegate:delegate];
}

- (JSContext *)jsContext
{
    return objc_getAssociatedObject(self, &kJSContext);
}

#pragma mark - function

void webViewDidFinishLoad(id self, SEL _cmd, UIWebView * webView)
{
    /**
     *  just runtime use
     * do nothing
     */
}

@end
