//
//  HHRouterManager.m
//  FunnyTicket
//
//  Created by tasama on 17/5/22.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHRouterManager.h"
#import "HHRouterUrl.h"
#import "HHRouterManagerDelegate.h"
//#import "HHWebViewController.h"
#import "HHLogSystem.h"
#import <objc/runtime.h>
#import <HHFoundation/HHMarco.h>

typedef NSArray HHRouterUrlInfo;

@interface HHRouterManager ()

@property (nonatomic, strong) NSMutableDictionary *routers;

@property (nonatomic, strong) NSMutableArray *mapUrls;

@end

@implementation HHRouterManager

+ (void)load {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"URLRouterLoadVC.plist" ofType:nil];
    NSArray *routers = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *router in routers) {
        
        NSString *key = [router valueForKey:@"URLKey"];
        NSString *viewControllerName = [router objectForKey:@"ViewController"];
        [HHRouterManager registerUrl:key withController:NSClassFromString(viewControllerName)];
    }
    
    path = [[NSBundle mainBundle] pathForResource:@"ModuleEnterUrls.plist" ofType:nil];
    routers = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *router in routers) {
        
        NSString *url = router[@"url"];
        NSString *controller = router[@"controller"];
        [HHRouterManager registerUrl:url withController:NSClassFromString(controller)];
    }
}

+ (void)analyseUrl:(NSString *)urlString withResult:(void (^)(NSString *, NSDictionary * _Nullable))resultBlock {
    
    HHRouterManager *manager = [HHRouterManager shared];
    NSRange range = [urlString rangeOfString:@"?"];
    
    NSString *parameterString = @"";
    NSString *classPartString = @"";
    if (range.location != NSNotFound) {
        
        parameterString = [urlString substringFromIndex:([urlString rangeOfString:@"?"].location + 1)];//urlAndParametersArr.lastObject; // 参数字符串段
        classPartString = [[urlString substringToIndex:([urlString rangeOfString:@"?"].location)] lowercaseString];//;[urlAndParametersArr.firstObject lowercaseString]; //匹配字符串段
    } else {
        
        classPartString = [urlString lowercaseString];
    }
    
    NSMutableDictionary *info = [manager ansylizeInfo:parameterString];
    
    if (resultBlock) {
        
        resultBlock(classPartString, info);
    }
}

#define BASE64TYPE @"#codeBybase64Encoding#"
#define ENCODINGLENGTH [@"#codeBybase64Encoding#" length]

+ (void)registerUrl:(NSString *)url withBlock:(HHRouterHandler)handler {
    
    if (![self checkUrlWith:url]) return;
    
    [[HHRouterManager shared].mapUrls addObject:url];
    
    NSMutableDictionary *dict = [[self shared] ansylizeWithUrl:url];
    
    dict[@"block"] = handler;
}

+ (void)registerUrl:(NSString *)url withController:(Class)controller {
    
    if (![self checkUrlWith:url]) return;
    
    [[HHRouterManager shared].mapUrls addObject:url];
    
    NSMutableDictionary *dict = [[self shared] ansylizeWithUrl:url];
    
    dict[@"_"] = controller;
}

+ (void)openUrl:(NSString *)url with:(id)controller andAnimation:(BOOL)animation {
    
    [self openUrl:url with:controller andAnimation:animation with:^BOOL(NSDictionary *parameters) {
        
        return YES;
        
    } andFailedController:nil];
}

+ (void)openUrl:(NSString *)url with:(id)controller andAnimation:(BOOL)animation with:(BOOL (^)(NSDictionary *))openPermission andFailedController:(UIViewController *)failedVC {
    
    if (![self checkUrlWith:url]) return;
    
    UIViewController *vc = [self matchUrl:url];
    BOOL canOpen = openPermission(vc.parameters);
    if (canOpen) {
        
        if (!vc) {
            
            return;
        }
        
        if ([vc isKindOfClass:[UINavigationController class]]) {
            
            if ([controller isKindOfClass:[UINavigationController class]]) {
                
                UINavigationController *nav = (UINavigationController *)controller;
                [nav.topViewController presentViewController:vc animated:YES completion:nil];
                
            } else if ([controller isKindOfClass:[UIViewController class]]) {
                
                [controller presentViewController:vc animated:YES completion:nil];
            }
        } else {
            
            if ([controller isKindOfClass:[UINavigationController class]]) {
                
                UINavigationController *nav = (UINavigationController *)controller;
                [nav pushViewController:vc animated:animation];
            } else {
                
                if (controller && [controller isKindOfClass:[UIViewController class]]) {
                    
                    [controller presentViewController:vc animated:animation completion:nil];
                } else {
                    
                    HHLogError(@"controller不存在");
                }
            }
        }

    } else {
            
            if ([controller isKindOfClass:[UINavigationController class]]) {
                
                UINavigationController *nav = controller;
                if (failedVC && ![failedVC isKindOfClass:[UINavigationController class]]) {
                    
                    [nav pushViewController:failedVC animated:YES];
                }
            } else if ([controller isKindOfClass:[UIViewController class]]) {
                
                [controller presentViewController:vc animated:YES completion:nil];
        }
    }
}

+ (id)matchUrl:(NSString *)url {
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (![self checkUrlWith:url]) return nil;
    
    url = [self checkSchemeWith:url];
    
    if ([[[NSURL URLWithString:url].scheme lowercaseString] isEqualToString:@"http"] || [[[NSURL URLWithString:url].scheme lowercaseString] isEqualToString:@"https"]) {
        Class HHWebViewControllerClass = NSClassFromString(@"HHWebViewController");
        if (HHWebViewControllerClass) {
            UIViewController *webVC = [[HHWebViewControllerClass alloc] init];
            if ([webVC respondsToSelector:@selector(setUrl:)]) {
                [webVC performSelector:@selector(setUrl:) withObject:[NSURL URLWithString:url]];
            }
            return webVC;
        }
    }
    
    id result = [self matchControllerWithUrl:url];
    if (result) {
        
        return result;
    } else {
        
        //进入模块搜索
        return [self matchModuleWithUrl:url];
    }
}

+ (HHRouterUrlInfo *)handleWithUrl:(NSString *)url byManager:(HHRouterManager *)manager {
    
    NSRange range = [url rangeOfString:@"?"];
    
    NSString *parameterString = @"";
    NSString *classPartString = @"";
    if (range.location != NSNotFound) {
        
        parameterString = [url substringFromIndex:([url rangeOfString:@"?"].location + 1)];//urlAndParametersArr.lastObject; // 参数字符串段
        classPartString = [[url substringToIndex:([url rangeOfString:@"?"].location)] lowercaseString];//;[urlAndParametersArr.firstObject lowercaseString]; //匹配字符串段
    } else {
        
        classPartString = [url lowercaseString];
    }
    NSMutableDictionary *info = [manager ansylizeInfo:parameterString];

    NSString *scheme = [NSURL URLWithString:classPartString].scheme;
    NSString *host = [NSURL URLWithString:classPartString].host;
    NSArray *components = [NSURL URLWithString:classPartString].path.pathComponents;
    NSMutableArray *temp = @[].mutableCopy;
    for (NSString *key in components) {
        
        if ([key isEqualToString:@"/"]) continue;
        [temp addObject:key];
    }
    components = temp.copy;
    return @[scheme, host, components,parameterString,classPartString,info];
}

//模块搜索
+ (id)matchModuleWithUrl:(NSString *)url {
    
    NSLog(@"转入模块化搜索...");
    HHRouterManager *manager = [HHRouterManager shared];
    HHRouterUrlInfo *urlHandle = [self handleWithUrl:url byManager:manager];
    
    NSString *scheme = urlHandle[0];
    NSString *host = urlHandle[1];
    NSArray *components = urlHandle[2];
    NSString *parameterString = urlHandle[3];
    NSString *classPartString = urlHandle[4];
    NSMutableDictionary *info = urlHandle[5];
    
    NSMutableArray *road = @[host].mutableCopy;
    [road addObjectsFromArray:components];
    NSDictionary *router = [HHRouterManager shared].routers[scheme];
    
    id <HHRouterManagerSourceDelegate> enter = [self anyliseComponentsWithDict:router andRoad:road andIndex:0];
    HHRouterUrl *routerUrl = [[HHRouterUrl alloc] initWithUrl:classPartString];
    routerUrl.parameters = info;
    if ([enter respondsToSelector:@selector(viewControllerWithUrl:)]) {
        
        return [enter viewControllerWithUrl:routerUrl];
    }
    return nil;
}

+ (id)anyliseComponentsWithDict:(NSDictionary *)dic andRoad:(NSMutableArray *)arr andIndex:(NSUInteger)index {

    if (index > arr.count - 1) {
        
        return nil;
    }
    if (dic[@"_"]) {
        
        Class controller = dic[@"_"];
        id target = nil;
        @try {
            
            target = [[controller alloc] init];
        } @catch (NSException *exception) {
            
            HHLogError(@"exception!!--> name:%@, reason:%@, info:%@",exception.name, exception.reason, exception.userInfo);
        }
        
        if (!target) {
            
            return nil;
        }
        return target;
    }
    
    dic = dic[arr[index]];
    if (!dic) {
        
        return nil;
    }
    index += 1;
    return [self anyliseComponentsWithDict:dic andRoad:arr andIndex:index];
}

//控制器搜索
+ (id)matchControllerWithUrl:(NSString *)url {
    
    HHRouterManager *manager = [HHRouterManager shared];
    HHRouterUrlInfo *urlHandle = [self handleWithUrl:url byManager:manager];

    NSString *scheme = urlHandle[0];
    NSString *host = urlHandle[1];
    NSArray *components = urlHandle[2];
    NSString *parameterString = urlHandle[3];
    NSString *classPartString = urlHandle[4];
    NSMutableDictionary *info = urlHandle[5];
    
    NSMutableDictionary *dict;
    for (NSString *key in manager.routers.allKeys) {
        
        if ([scheme isEqualToString:key]) {
            
            dict = manager.routers[key];
            break;
        }
    }
    for (NSString *key in dict.allKeys) {
        
        if ([host isEqualToString:key]) {
            
            dict = dict[key];
        }
    }
    
    for (NSString *component in components) {
        
        if ([component isEqualToString:@"/"]) continue;
        dict = dict[component];
    }
    //为block
    if (dict[@"block"]) {
        
        HHRouterHandler hander = dict[@"block"];
        if (hander) {
            
            return hander(info);
        }
    }
    
    Class controller = dict[@"_"];
    id target = nil;
    @try {
        
        target = [[controller alloc] init];
    } @catch (NSException *exception) {
        
        HHLogError(@"exception!!--> name:%@, reason:%@, info:%@",exception.name, exception.reason, exception.userInfo);
    }
    
    if (!target) {
        
        //此处可做错误处理
        HHLogError(@"找不到与%@匹配的控制器", url);
        return nil;
    }
    
    if (![target isKindOfClass:[UIViewController class]]) {
        
        //do
        HHLogError(@"匹配到的%@不是一个控制器", NSStringFromClass([target class]));
        return nil;
    }
    
    UIViewController *targetVC = (UIViewController *)target;
    if (parameterString.length > 0) {
        
        //有参数
        [targetVC setParameters:info];
    }
    return targetVC;
}

+ (NSArray<NSString *> *)getAllUrls {
    
    return [[self shared] mapUrls].copy;
}

#pragma mark - private
+ (instancetype)shared {
    
    static HHRouterManager *routerManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        routerManager = [[HHRouterManager alloc] init];
    });
    
    return routerManager;
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.routers = @{}.mutableCopy;
        self.mapUrls = @[].mutableCopy;
    }
    return self;
}

- (NSMutableDictionary *)ansylizeWithUrl:(NSString *)urlString {
    
    urlString = [HHRouterManager checkSchemeWith:urlString];
    
    urlString = [urlString lowercaseString];

    NSURL *url = [NSURL URLWithString:urlString];
    NSString *scheme = url.scheme;
    NSString *host = url.host;
    NSArray *components = url.path.pathComponents;
    
    if (!self.routers[scheme]) {
        
        self.routers[scheme] = @{}.mutableCopy;
    }
    NSMutableDictionary *routerDic = self.routers[scheme];
    
    if (!routerDic[host]) {
        
        routerDic[host] = @{}.mutableCopy;
    }
    
    routerDic = routerDic[host];
    for (NSString *component in components) {
        
        if ([component isEqualToString:@"/"]) continue;
        
        if (!routerDic[component]) {
            
            routerDic[component] = @{}.mutableCopy;
        }
        
        routerDic = routerDic[component];
    }
    return routerDic;
}

- (NSMutableDictionary *)ansylizeInfo:(NSString *)parameters {
    
    NSArray *parametersArr = [parameters componentsSeparatedByString:@"&"];
    
    NSMutableDictionary *info = @{}.mutableCopy;
    for (NSString *singleParameter in parametersArr) {
            NSRange range = [singleParameter rangeOfString:@"="];
            NSString *key = @"";
            id value = @"";
            if (range.location != NSNotFound) {
                
                key = [singleParameter substringToIndex:range.location];
                value = [singleParameter substringFromIndex:(range.location + 1)];
            }
            
            if (kStringIsEmpty(key) || kStringIsEmpty(value)) {
                
                continue;
            }
            info[key] = value;
        }
    return info;
}

+ (NSString *)checkSchemeWith:(NSString *)url {
    
    NSString *urlTemp = [url lowercaseString];
    
    if (![urlTemp hasPrefix:@"heyhou://"] && ![urlTemp hasPrefix:@"http://"] && ![urlTemp hasPrefix:@"https://"]) {
        
        if ([urlTemp hasPrefix:@"/"]) {
            
            return [@"heyhou:/" stringByAppendingString:url];
        }
        
        return [@"heyhou://" stringByAppendingString:url];
    }
    
    return url;
}

+ (BOOL)checkUrlWith:(NSString *)urlString {
    if (!urlString || urlString.length == 0) {
        return NO;
    }
    
    urlString = [[self checkSchemeWith:urlString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURL *url = [NSURL URLWithString:urlString];
    
    if (!url.host) {
        
        return NO;
    }
    
    return YES;
}

@end

@implementation HHRouterUrlConstructer

+ (NSString *)constructUrlWith:(NSString *)url andOptions:(NSDictionary *)info {
    
    __block NSString *urlMutable = [url stringByAppendingString:@"?"];
    [info enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSString *string = @"";
        if ([obj isKindOfClass:[NSString class]]){
            
            string = obj;
            
        } else if ([obj isKindOfClass:[NSNumber class]]) {
            
            string = [obj stringValue];
            
        } else {
            
            if (![obj isKindOfClass:[NSArray class]] && ![obj isKindOfClass:[NSDictionary class]]) {
                
                return;
            }
            NSError *error = nil;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                               options:NSJSONWritingPrettyPrinted
                                                                 error:&error];
            
            string = [[jsonData base64EncodedStringWithOptions:NSUTF8StringEncoding] stringByAppendingString:BASE64TYPE];
        }
        NSString *str = [NSString stringWithFormat:@"%@=%@&", key, string];
        
        urlMutable = [urlMutable stringByAppendingString:str];
    }];
    
    return [urlMutable substringToIndex:(urlMutable.length - 1)];
}

@end

@implementation UIViewController (HHRouterManager)

- (void)setParameters:(NSMutableDictionary *)parameters {
    
    objc_setAssociatedObject(self, @"parameters", parameters, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)parameters {
    
    return objc_getAssociatedObject(self, @"parameters");
}

@end
