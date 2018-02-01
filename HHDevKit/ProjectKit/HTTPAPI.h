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
//  HTTPAPI.h
//  ProjectKit
//
//  Created by xun on 16/12/12.
//  Copyright © 2016年 Xun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "Macro.h"

@class HTTPAPI;

@protocol HTTPAPIDelegate <NSObject>

- (void)fetchData:(id)data fromServerSuccessWithAPI:(HTTPAPI *)api;

- (void)fetchDataFailedWithError:(NSError *)err api:(HTTPAPI *)api;

@end

typedef enum
{
    GET,
    POST
} RequestType;

typedef NSInteger HHRequestReturnCode;
typedef NSString HHRequestErrorInfoKey;

@interface HTTPAPI : NSObject

@property (nonatomic, readonly) NSString *methodName;
@property (nonatomic, readonly) NSDictionary *parameters;
@property (nonatomic, readonly) NSString *url;

@property (nonatomic, strong) NSURLSessionTask *dataTask;
@property (nonatomic, assign) id <HTTPAPIDelegate> delegate;
@property (nonatomic, strong) AFHTTPSessionManager *manager;

+ (NSString *)serverDomain;

+ (instancetype)apiWithDelegate:(id <HTTPAPIDelegate>)delegate;


/**
 GET请求，从服务器请求数据
 */
- (void)getDataFromServer;

/**
 GET请求，从服务器请求数据，并显示加载时文字

 @param msg     加载时显示文字
 @param view    活动指示器的父视图，默认在KeyWindow上
 */
- (void)getDataFromServerWithLodingMsg:(NSString *)msg onView:(UIView *)view;

/**
 POST请求，发送数据至服务器
 */
- (void)postDataToServer;

/**
  POST请求，从服务器请求数据，并显示加载时文字
  
  @param msg    加载时显示文字
  @param view   活动指示器的父视图，默认在KeyWindow上
  */
- (void)postDataToServerWithLodingMsg:(NSString *)msg onView:(UIView *)view;


/**
 *  http请求，无活动指示器
 *
 *  @param type       类型
 *  @param parameters 参数
 *  @param method     方法
 *  @param success    成功回调
 *  @param failed     失败回调
 *
 *  @return 当前任务
 */
+ (NSURLSessionDataTask *)requestWithType:(RequestType)type
                               parameters:(NSDictionary *)parameters
                                   method:(NSString *)method
                                  success:(void (^)(NSURLSessionTask *, id))success
                                   failed:(void (^)(NSURLSessionTask *, NSError *))failed;

/**
 *  http请求，有活动指示器
 *
 *  @param type       类型
 *  @param parameters 参数
 *  @param method     方法
 *  @param success    成功回调
 *  @param failed     失败回调
 *  @param lodingMsg  加载时显示文字
 *  @param view       活动指示器的父视图，默认在KeyWindow上
 *
 *  @return 当前任务
 */
+ (NSURLSessionDataTask *)requestWithType:(RequestType)type
                               parameters:(NSDictionary *)parameters
                                   method:(NSString *)method
                                  success:(void (^)(NSURLSessionTask *, id))success
                                   failed:(void (^)(NSURLSessionTask *, NSError *))failed
                                lodingMsg:(NSString *)msg
                                   onView:(UIView *)view;

@end

XUNExtern const HHRequestErrorInfoKey *HHRequestErrorDetailInfo;
XUNExtern const HHRequestErrorInfoKey *HHRequestErrorDescription;

XUNExtern const HHRequestReturnCode HHRequestFailedWithoutLoginCode;
XUNExtern const HHRequestReturnCode HHRequestSuccessCode;
