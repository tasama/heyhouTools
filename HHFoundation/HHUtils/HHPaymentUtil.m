//
//  HHPaymentUtil.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 4/11/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "HHPaymentUtil.h"
#import "HHLogSystem.h"

//#define Scheme @"heyhou" 通过属性配置

@implementation HHPaymentUtil

static HHPaymentUtil *instance = nil;
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
        instance.blocks = @{}.mutableCopy;
        [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(payFailed:) name:PayFailedName object:nil];
    });
    return instance;
}
int payTag = 0;
- (void)wechatPayWithPayInfo:(id )payInfo Callback:(PayCompletionBlock)completionBlock
{
    [[HHPaymentUtil shareInstance].blocks addEntriesFromDictionary:@{@"wxPay":completionBlock}];
    if ([payInfo isKindOfClass:[NSDictionary class]])
    {
        payTag = 100;
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.partnerId           = [payInfo objectForKey:@"partnerid"];
        req.prepayId            = [payInfo objectForKey:@"prepayid"];
        req.nonceStr            = [NSString stringWithFormat:@"%@",[payInfo objectForKey:@"noncestr"]];
        req.timeStamp           = [[payInfo objectForKey:@"timestamp"] intValue];
        req.package             = [payInfo objectForKey:@"package"];
        req.sign                = [payInfo objectForKey:@"sign"];
        [WXApi sendReq:req];
        return;
    }
    HHLogDebug(@"payInfo is not a dictionary!");
}

- (void)alipayPayWithPayInfo:(id)payInfo Callback:(PayCompletionBlock)completionBlock
{
    [[HHPaymentUtil shareInstance].blocks addEntriesFromDictionary:@{@"aliPay":completionBlock}];
    payTag = 100;
    [[AlipaySDK defaultService] payOrder:payInfo fromScheme:self.scheme callback:^(NSDictionary *resultDic) {
        payTag = 0;
        NSString *status = [resultDic objectForKey:@"resultStatus"];
        completionBlock([status intValue]);
    }];
}

#pragma mark - WXApiDelegate

- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvMessageResponse:)])
        {
            SendMessageToWXResp *messageResp = (SendMessageToWXResp *)resp;
            [_delegate managerDidRecvMessageResponse:messageResp];
        }
    }
    else if ([resp isKindOfClass:[SendAuthResp class]])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvAuthResponse:)])
        {
            SendAuthResp *authResp = (SendAuthResp *)resp;
            [_delegate managerDidRecvAuthResponse:authResp];
        }
    }
    else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvAddCardResponse:)])
        {
            AddCardToWXCardPackageResp *addCardResp = (AddCardToWXCardPackageResp *)resp;
            [_delegate managerDidRecvAddCardResponse:addCardResp];
        }
    }
    else if([resp isKindOfClass:[PayResp class]])
    {
        //支付返回结果，实际支付结果需要去微信服务器端查询
        PayCompletionBlock block = [instance.blocks objectForKey:@"wxPay"];
        payTag = 0;
        if (block)
        {
            block(resp.errCode);
        }
    }
    
}

- (void)onReq:(BaseReq *)req
{
    if ([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvGetMessageReq:)])
        {
            GetMessageFromWXReq *getMessageReq = (GetMessageFromWXReq *)req;
            [_delegate managerDidRecvGetMessageReq:getMessageReq];
        }
    }
    else if ([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvShowMessageReq:)])
        {
            ShowMessageFromWXReq *showMessageReq = (ShowMessageFromWXReq *)req;
            [_delegate managerDidRecvShowMessageReq:showMessageReq];
        }
    }
    else if ([req isKindOfClass:[LaunchFromWXReq class]])
    {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvLaunchFromWXReq:)])
        {
            LaunchFromWXReq *launchReq = (LaunchFromWXReq *)req;
            [_delegate managerDidRecvLaunchFromWXReq:launchReq];
        }
    }
}

#pragma mark - private

- (void)payFailed:(NSNotification *)noti
{
    if (payTag == 100) {
        PayCompletionBlock wxBlock = [instance.blocks objectForKey:@"wxPay"];
        if (wxBlock)
        {
            wxBlock(1234);
        }
        PayCompletionBlock alipayBlock = [instance.blocks objectForKey:@"aliPay"];
        if (alipayBlock)
        {
            alipayBlock(1234);
        }

    }
}

@end
