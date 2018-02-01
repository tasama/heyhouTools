//
//  ZFNetTool.m
//  ZFDemos
//
//  Created by XiaoZefeng on 21/9/16.
//  Copyright © 2016年 肖泽峰. All rights reserved.
//

#import "HHNetTool.h"
#import "AFNetworking.h"
#import "YYCache.h"
#import "HHRequestSignTool.h"
#import "HHLogSystem.h"

#import  "UIDevice+DeviceModel.h"

@interface HHNetTool ()



@end
static NSString * const HttpRequestCache = @"HttpRequestCache";

@implementation HHNetTool

static HHNetTool *shareInstance = nil;

+ (instancetype _Nullable)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

+ (AFHTTPSessionManager *)sessionManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // <=== 直接使用AF的JSON解析结果,去除自己解析代码
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 25.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *sysStr = [NSString stringWithFormat:@"IOS|%@", [[UIDevice currentDevice] systemVersion]];
    NSString *headerStr = [NSString stringWithFormat:@"sys:%@,app:%@|%@", sysStr, appCurVersion, [[UIDevice currentDevice] deviceModel]];
    [manager.requestSerializer setValue:headerStr forHTTPHeaderField:@"X-Heyhou-Header"];//X_Heyhou_Header:"sys:IOS|10.1.0,app:2.0.1|iPhone 6"
    [manager.requestSerializer setValue:[UIDevice deviceUUID] forHTTPHeaderField:@"X-Heyhou-DeviceId"];
     
    [self addSPRequestHeader:manager.requestSerializer];
    
    return manager;
}
// !!特别版本特有请求头!!
+ (void)addSPRequestHeader:(AFHTTPRequestSerializer *)req {
    // !!!特别版本,正常版本无此项内容!!!
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDictionary objectForKey:@"HeyhouAppName"];
    if (appName) {
        [req setValue:appName forHTTPHeaderField:@"X-Heyhou-AppName"];
    }
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(successBlock)success failure:(failureBlock)failure
{
    parameters = [HHRequestSignTool signRequestWithParameters:parameters];
    
    URLString = [HHNetTool.shareInstance.serverAddress stringByAppendingString:URLString];
    //HHLogDebug(@"url : %@",URLString);
    //HHLogDebug(@"param ==: %@",parameters);
    if ([URLString length] > 0)
    {
        //判断url格式
        URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[self sessionManager] POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //HHLogDebug(@"response object : %@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
                if (success)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        success(responseObject);
                    });
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        failure(error);
                    });
                }
            }];
        });
    }
    else
    {
        HHLogDebug(@"url 长度为0");
    }
}

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(successBlock)success failure:(failureBlock)failure
{
    URLString = [HHNetTool.shareInstance.serverAddress stringByAppendingString:URLString];
    if ([URLString length] > 0)
    {
        URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[self sessionManager] GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        success(responseObject);
                    });
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        failure(error);
                    });
                }
            }];
        });
    }
    else
    {
        HHLogDebug(@"url 长度为0");
    }
}

+ (void)GET:(NSString * _Nonnull)URLString parameters:(id _Nullable)parameters cachePolicy:(RequestCachePolicy)cachePolicy
    success:(successBlock _Nullable)success
    failure:(failureBlock _Nonnull)failure
{
    NSString *urlString = [HHNetTool.shareInstance.serverAddress stringByAppendingString:URLString];
    
    NSString *cacheKey = urlString;
    if (parameters) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        NSString *paramStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        cacheKey = [urlString stringByAppendingString:paramStr];
        
    }
    YYCache *cache = [[YYCache alloc] initWithName:HttpRequestCache];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
    id object = [cache objectForKey:cacheKey];
    
    switch (cachePolicy) {
        case ReloadIgnoringLocalCacheData: {//忽略本地缓存直接请求
            //不做处理，直接请求
            break;
        }
        case ReturnCacheDataAfterLoadError: {//先请求数据，请求出错后才返回缓存
            //不做处理，直接请求
            break;
        }
        case ReturnCacheDataElseLoad: {//有缓存就返回缓存，没有就请求
            if (object) {//有缓存
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(object);
                });
                return;
            }
            break;
        }
        case ReturnCacheDataDontLoad: {//有缓存就返回缓存,从不请求（用于没有网络）
            if (object) {//有缓存
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(object);
                });
                
            }
            return ;//退出从不请求
        }
        default: {
            break;
        }
    }

    if ([urlString length] > 0)
    {
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[self sessionManager] GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //HHLogDebug(@"response object : %@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
                
                [cache setObject:responseObject forKey:cacheKey];//YYCache 已经做了responseObject为空处理
                if (success)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        success(responseObject);
                    });
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if ((error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorNetworkConnectionLost) && cachePolicy == ReturnCacheDataAfterLoadError && object)
                        {
                            success(object);
                        }
                            
                        failure(error);
                    });
                }
            }];
        });
    }
    else
    {
        HHLogDebug(@"url 长度为0");
    }
}

+ (void)POSTJSONType:(NSString *)URLString parameters:(id)parameters success:(successBlock)success failure:(failureBlock)failure {
    
    URLString = [HHNetTool.shareInstance.serverAddress stringByAppendingString:URLString];
    if ([URLString length] > 0) {
        
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:nil error:nil];
        
        req.timeoutInterval= 25.0f;
        [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [req setValue:@"text/html" forHTTPHeaderField:@"Accept"];
        [req setHTTPBody:[parameters dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSString *sysStr = [NSString stringWithFormat:@"IOS|%@", [[UIDevice currentDevice] systemVersion]];
        NSString *headerStr = [NSString stringWithFormat:@"sys:%@,app:%@|%@", sysStr, appCurVersion, [[UIDevice currentDevice] deviceModel]];
        [req setValue:headerStr forHTTPHeaderField:@"X-Heyhou-Header"];//X_Heyhou_Header:"sys:IOS|10.1.0,app:2.0.1|iPhone 6"
        [req setValue:[UIDevice deviceUUID] forHTTPHeaderField:@"X-Heyhou-DeviceId"];
        
        [self addSPRequestHeader:req];
        
        [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (!error) {
                if (success)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        success(responseObject);
                    });
                }
            } else {
                if (failure)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        failure(error);
                    });
                }
                NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            }
        }] resume];
    }
}
    
+ (NSDictionary *)getURLParameters:(NSString *)urlStr {
    // 查找参数
    NSRange range = [urlStr rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [urlStr substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params.copy;
}

@end
