//
//  HHPaymentUtil.h
//  FunnyTicket
//
//  Created by XiaoZefeng on 4/11/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>

/*****scheme 需要由每个APP自行配置，不在提供宏定义提供, 2017-11-8******/

@protocol HHPaymentUtilDelegate <NSObject>

@optional

- (void)managerDidRecvGetMessageReq:(GetMessageFromWXReq *)request;

- (void)managerDidRecvShowMessageReq:(ShowMessageFromWXReq *)request;

- (void)managerDidRecvLaunchFromWXReq:(LaunchFromWXReq *)request;

- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)response;

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response;

- (void)managerDidRecvAddCardResponse:(AddCardToWXCardPackageResp *)response;

@end

typedef void (^PayCompletionBlock) (int errCode);

#define PayFailedName @"payFailed"

@interface HHPaymentUtil : NSObject <WXApiDelegate>

@property (nonatomic, copy) NSString *scheme; //配置当前APP的scheme

+ (instancetype)shareInstance;

@property (nonatomic, weak) id <HHPaymentUtilDelegate> delegate;

@property (nonatomic , strong)NSMutableDictionary *blocks;

/**
 微信支付

 @param payInfo 拼接信息
 @param completionBlock 错误码回调
 */
//错误码 0成功  -1失败(可能的原因：签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等。)  -2无需处理。发生场景：用户不支付了，点击取消，返回APP。 1234
- (void)wechatPayWithPayInfo:(id )payInfo Callback:(PayCompletionBlock)completionBlock;

/**
 支付宝支付

 @param payInfo 拼接信息
 @param completionBlock 错误码回调
 */
//错误码 9000订单支付成功 8000	正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态 4000	订单支付失败 6001	用户中途取消 6002	网络连接出错 1234
//6004	支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态  其它	其它支付错误
- (void)alipayPayWithPayInfo:(id )payInfo Callback:(PayCompletionBlock)completionBlock;

@end
