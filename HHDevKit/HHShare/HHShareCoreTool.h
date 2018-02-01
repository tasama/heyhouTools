//
//  HHShareCoreTool.h
//  FunnyTicket
//
//  Created by tasama on 17/5/2.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>
#import <Singleton.h>

#pragma mark - shareType 分享类型

typedef enum {
    
    CoreSocialplatformTypeQQ,
    
    CoreSocialplatformTypeWechatSession,
    
    CoreSocialplatformTypeQzone,
    
    CoreSocialplatformTypeWechatTimeLine,
    
    CoreSocialplatformTypeSina
    
} CoreSocialplatformType;

#pragma mark - 分享内容参数
#define kShareCoreTitle @"kShareTitle"//标题
#define kShareCoreContent @"kShareContent"//内容
#define kShareCoreUrl @"kShareUrl"//分享url
#define kShareCoreImage @"kShareCoreImage"//分享的封面图片
#define kShareCoreImageUrl @"kShareCoreImageUrl"//分享的封面url

typedef enum {
    
    CoreSocialUrlTypeDefault,             //无
    CoreSocialUrlTypeMedia,               //即内容：视频，音频，图片
    CoreSocialUrlTypeActivity,            //活动
    CoreSocialUrlTypeTopic,               //专题
    CoreSocialUrlTypePerformance,         //演出
    CoreSocialUrlTypeLive,                //直播
    CoreSocialUrlTypeTicket,              //票务
    CoreSocialUrlTypeCrowd,               //众筹
    CoreSocialUrlTypePost                 //帖子
}CoreSocialUrlType;

typedef void(^ShareComplition)(NSError *_Nullable error);

typedef void(^UMLoginComplition)(NSError *_Nullable error, UMSocialUserInfoResponse *_Nullable result);

@interface HHShareCoreTool : NSObject

single_interface(HHShareCoreTool)

- (void)shareWithType:(CoreSocialplatformType)shareType andMediaType:(CoreSocialUrlType)type andMediaId:(NSInteger)mediaId andController:(UIViewController *_Nonnull)controller andOtherOptions:(NSDictionary *_Nullable)option withComplition:(ShareComplition _Nullable)complitionBlock  userAction:(void (^)(NSInteger mediaID, NSInteger mediaType))action;

@end

@interface HHUMLoginCoreTool : NSObject

+ (void)getUserInfoForPlatform:(CoreSocialplatformType)shareType superVC:(UIViewController *)vc withComplited:(UMLoginComplition _Nullable)complitionBlock;

+ (BOOL)getTypeInstall:(CoreSocialplatformType)type;

@end
