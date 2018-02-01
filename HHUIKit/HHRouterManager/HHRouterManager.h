//
//  HHRouterManager.h
//  FunnyTicket
//
//  Created by tasama on 17/5/22.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HHRouterUrls.h"

typedef id (^HHRouterHandler) (NSDictionary *parameters);

@interface HHRouterManager : NSObject


+ (void)analyseUrl:(NSString *)urlString withResult:(void (^)(NSString *url, NSDictionary *_Nullable parameters))resultBlock;

/**
 注册blockUrl

 @param url     用以注册的url
 @param handler 注册的回调
 */
+ (void)registerUrl:(NSString *)url withBlock:(HHRouterHandler)handler;

/**
 注册控制器url

 @param url        用以注册的url
 @param controller 注册的控制器
 */
+ (void)registerUrl:(NSString *)url withController:(Class)controller;

/**
 匹配url

 @param url 用以匹配的url

 @return 返回匹配结果（如果匹配到的是block，则会直接执行这个block，并返回这个block的返回值）
 */
+ (id)matchUrl:(NSString *)url;

/**
 匹配url，直接打开回调结果的控制器

 @param url        url
 @param controller 当前控制器
 @param animation  animation
 */
+ (void)openUrl:(NSString *)url with:(id)controller andAnimation:(BOOL)animation;

/**
 匹配url，传入block用以控制是否打开该控制器，当block的返回值为YES，则可以打开，否则打开failedVC

 @param url            url
 @param controller     当前的控制器
 @param animation      animation
 @param openPermission 判断是否能够打开的block
 @param failedVC       打开失败时替换的vc
 */
+ (void)openUrl:(NSString *)url with:(id)controller andAnimation:(BOOL)animation with:(BOOL (^)(NSDictionary *parameters))openPermission andFailedController:(UIViewController *)failedVC;

/**
 获取全部注册的url

 @return 全部注册的url
 */
+ (NSArray <NSString *>*)getAllUrls;

@end

@interface HHRouterUrlConstructer : NSObject

/**
 构造url

 @param url  后台定义的url
 @param info 需要拼接的参数

 @return 返回拼接完成的url
 */
+ (NSString *)constructUrlWith:(NSString *)url andOptions:(NSDictionary *)info;

@end

@interface UIViewController (HHRouterManager)

@property (nonatomic, strong) NSMutableDictionary *parameters;

@end
