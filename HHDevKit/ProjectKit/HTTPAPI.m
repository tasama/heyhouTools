//
//  \\      //     ||          ||     ||\        ||
//   \\    //      ||          ||     ||\\       ||
//    \\  //       ||          ||     || \\      ||
//     \\//        ||          ||     ||  \\     ||
//      /\         ||          ||     ||   \\    ||
//     //\\        ||          ||     ||    \\   ||
//    //  \\       ||          ||     ||     \\  ||
//   //    \\      ||          ||     ||      \\ ||
//  //      \\      \\        //      ||       \\||
// //        \\      \\======//       ||        \||
//
//
//  HTTPAPI.m
//  ProjectKit
//
//  Created by xun on 16/12/12.
//  Copyright © 2016年 Xun. All rights reserved.
//

#import "HTTPAPI.h"
#import <objc/runtime.h>
#import <MBProgressHUD.h>
#import <HHFoundation/HHNetTool.h>

@interface HTTPAPI ()

@end

@implementation HTTPAPI

- (NSString *)methodName
{
    [NSException raise:@"没有实现方法" format:@"%@必须实现方法：%s", NSStringFromClass([self class]), __func__];
    
    return nil;
}

+ (NSString *)serverDomain {
    
    return [HHNetTool shareInstance].serverAddress;
}

- (NSString *)url
{
    return [NSString stringWithFormat:@"%@/%@", [HTTPAPI serverDomain], self.methodName];
}

- (NSDictionary *)parameters
{
    return [self keysAndValues];
}

+ (instancetype)apiWithDelegate:(id<HTTPAPIDelegate>)delegate
{
    HTTPAPI *api = [[self alloc] init];
    
    api.delegate = delegate;
    
    return api;
}

#pragma mark - Interface Method

- (void)getDataFromServer {
    
    [self requestWithType:GET loadingMsg:nil onView:nil];
}

- (void)getDataFromServerWithLodingMsg:(NSString *)msg onView:(UIView *)view{
    
    if (!msg) {
        
        msg = @"正在加载数据...";
    }
    
    if (!view) {
        
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    [self requestWithType:GET loadingMsg:msg onView:view];
}

- (void)postDataToServer {
    
    [self requestWithType:POST loadingMsg:nil onView:nil];
}

- (void)postDataToServerWithLodingMsg:(NSString *)msg onView:(UIView *)view {
    
    if (!msg) {
        
        msg = @"正在加载数据...";
    }
    
    if (!view) {
        
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    [self requestWithType:GET loadingMsg:msg onView:view];
}

+ (NSURLSessionDataTask *)requestWithType:(RequestType)type
                               parameters:(NSDictionary *)parameters
                                   method:(NSString *)method
                                  success:(void (^)(NSURLSessionTask *, id))success
                                   failed:(void (^)(NSURLSessionTask *, NSError *))failed {
    
    return [self requestWithType:type
                      parameters:parameters
                          method:method
                         success:success
                          failed:failed
                      loadingMsg:nil
                          onView:nil];
}

+ (NSURLSessionDataTask *)requestWithType:(RequestType)type
                               parameters:(NSDictionary *)parameters
                                   method:(NSString *)method
                                  success:(void (^)(NSURLSessionTask *, id))success
                                   failed:(void (^)(NSURLSessionTask *, NSError *))failed
                                lodingMsg:(NSString *)msg
                                   onView:(UIView *)view{
    if (!msg) {
        
        msg = @"正在加载数据...";
    }
    
    if (!view) {
        
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    return [self requestWithType:type
                      parameters:parameters
                          method:method
                         success:success
                          failed:failed
                      loadingMsg:msg
                          onView:view];
}

#pragma mark - Private Method

- (void)requestWithType:(RequestType)type loadingMsg:(NSString *)msg onView:(UIView *)view
{
    if (msg) {
        
        [HTTPAPI showProgressHUDOnView:view withText:msg];
    }
    
    if (type == GET)
    {
        [self.manager GET:self.url parameters:self.parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable dict) {
            
            [HTTPAPI hideProgressHUDForView:view];
            
            if ([dict[@"ret"] integerValue] == HHRequestSuccessCode) {
                
                if ([self.delegate respondsToSelector:@selector(fetchData:fromServerSuccessWithAPI:)])
                {
                    [self.delegate fetchData:dict[@"data"] fromServerSuccessWithAPI:self];
                }
            }
            else {
                
                NSError *error = [NSError errorWithDomain:@"网络请求错误！" code:[dict[@"ret"] integerValue] userInfo:@{HHRequestErrorDescription:dict[@"msg"], HHRequestErrorDetailInfo:dict[@"data"]}];
                
                if ([self.delegate respondsToSelector:@selector(fetchDataFailedWithError:api:)])
                {
                    [self.delegate fetchDataFailedWithError:error api:self];
                }
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [HTTPAPI hideProgressHUDForView:view];
            
            if ([self.delegate respondsToSelector:@selector(fetchDataFailedWithError:api:)])
            {
                [self.delegate fetchDataFailedWithError:error api:self];
            }
        }];
    }
    else if (type == POST)
    {
        [self.manager POST:self.url parameters:self.parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [HTTPAPI hideProgressHUDForView:view];
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            if ([dict[@"ret"] integerValue] == HHRequestSuccessCode) {
                
                if ([self.delegate respondsToSelector:@selector(fetchData:fromServerSuccessWithAPI:)])
                {
                    [self.delegate fetchData:dict[@"data"] fromServerSuccessWithAPI:self];
                }
            }
            else {
                
                NSError *error = [NSError errorWithDomain:@"网络请求错误！" code:[dict[@"ret"] integerValue] userInfo:@{HHRequestErrorDescription:dict[@"msg"], HHRequestErrorDetailInfo:dict[@"data"]}];
                
                if ([self.delegate respondsToSelector:@selector(fetchDataFailedWithError:api:)])
                {
                    [self.delegate fetchDataFailedWithError:error api:self];
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [HTTPAPI hideProgressHUDForView:view];
            
            if ([self.delegate respondsToSelector:@selector(fetchDataFailedWithError:api:)])
            {
                [self.delegate fetchDataFailedWithError:error api:self];
            }
        }];
    }
}

+ (NSURLSessionDataTask *)requestWithType:(RequestType)type
                               parameters:(NSDictionary *)parameters
                                   method:(NSString *)method
                                  success:(void (^)(NSURLSessionTask *, id))success
                                   failed:(void (^)(NSURLSessionTask *, NSError *))failed
                               loadingMsg:(NSString *)msg
                                   onView:(UIView *)view
{
    NSString *url = [NSString stringWithFormat:@"%@/%@", [HTTPAPI serverDomain], method];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    void (^Success)(NSURLSessionTask *task, id data) = ^(NSURLSessionTask *task, id data){
        
        [HTTPAPI hideProgressHUDForView:view];
        
        if ([data[@"ret"] integerValue] == HHRequestSuccessCode) {
            
            !success ? : success(task, data[@"data"]);
        }
        else {
            
            if (failed) {
                NSError *error = [NSError errorWithDomain:@"网络请求错误！" code:[data[@"ret"] integerValue] userInfo:@{HHRequestErrorDescription:data[@"msg"], HHRequestErrorDetailInfo:data[@"data"]}];
                failed(task, error);
            }
            //!false ? : failed(task, error);
        }
    };
    
    void (^Failed)(NSURLSessionTask *task, NSError *err) = ^(NSURLSessionTask *task, NSError *err){
    
        [HTTPAPI hideProgressHUDForView:view];
        
        !failed ? : failed(task, err);
    };
    
    if (type == GET)
    {
        return [manager GET:url parameters:parameters progress:nil success:Success failure:Failed];
    }
    else if (type == POST)
    {
        return [manager POST:url parameters:parameters progress:nil success:Success failure:Failed];
    }
    return nil;
}

- (AFHTTPSessionManager *)manager
{
    if (! _manager)
    {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

+ (void)showProgressHUDOnView:(UIView *)view
                     withText:(NSString *)text {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    
    hud.label.text = text;
    
    hud.mode = MBProgressHUDModeText;
    
    hud.removeFromSuperViewOnHide = YES;
    
    [view addSubview:hud];
    
    [hud showAnimated:YES];
}

+ (void)hideProgressHUDForView:(UIView *)view {
    
    [MBProgressHUD hideHUDForView:view animated:YES];
}

- (NSDictionary *)keysAndValues
{
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    for (int i = 0; i < count; i++)
    {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        
        id value = [self valueForKey:key];
        
        if (!value || [value isKindOfClass:[NSNull class]])
        {
            continue;
        }
        
        dict[key] = value;
    }
    
    return dict;
}

@end

const HHRequestErrorInfoKey *HHRequestErrorDescription = @"REQUEST_ERROR_DESCRIPTION";
const HHRequestErrorInfoKey *HHRequestErrorDetailInfo = @"REQUEST_ERROE_DETAIL_INFO";

const HHRequestReturnCode HHRequestFailedWithoutLoginCode = 1000;
const HHRequestReturnCode HHRequestSuccessCode = 0;
