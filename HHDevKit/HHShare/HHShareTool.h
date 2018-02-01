//
//  HHShareTool.h
//  FunnyTicket
//
//  Created by tasama on 16/11/25.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef enum {
    
    UrlResourceTypeDefault,             //无
    UrlResourceTypeMedia,               //即内容：视频，音频，图片
    UrlResourceTypeActivity,            //活动
    UrlResourceTypeTopic,               //专题
    UrlResourceTypePerformance,         //演出
    UrlResourceTypeLive,                //直播
    UrlResourceTypeTicket,              //票务
    UrlResourceTypeCrowd,               //众筹
    UrlResourceTypePost,                //帖子
    UrlResourceTypeMusic                //全曲播放分享
    
}UMSocialUrlType;

typedef void(^ShareSuccessed)();

typedef void(^ShareFailed)(NSInteger code);

@interface HHShareTool : NSObject

+ (instancetype _Nonnull)sharedInstanced;

//将分享完后调用HHNetAPI addUserSocialActionType:6 ObjectId:mediaId objectType:mediaType
//操作外移 2017-11-08
@property (nonatomic, strong) void(^userSocialActionBlock)(NSInteger mediaID, NSInteger mediaType);

/**
 分享界面弹出方法（直传图片）

 @param type            分享类型
 @param content         分享的文本
 @param image           分享的封面
 @param location        分享的坐标
 @param url             分享的web链接
 @param mediaId         分享的mediaId
 @param superController 分享界面弹出的控制器
 */
- (void)showShareViewWithShareType:(UMSocialUrlType)type andContent:(NSString *_Nullable)content andImage:(UIImage *_Nullable)image andLocaltion:(CLLocation *_Nullable)location andUrl:(NSString *_Nullable)url andMediaId:(NSInteger)mediaId andPushController:(UIViewController *_Nullable)superController Successed:(ShareSuccessed _Nullable)success Failed:(ShareFailed _Nullable)failed;

/**
 分享界面弹出方法（传图片url)

 @param type            分享类型
 @param content         分享的文本
 @param imageString     分享的封面UrlString
 @param location        分享的坐标
 @param url             分享的web链接
 @param mediaId         分享的mediaId
 @param superController 分享界面弹出的控制器
 */
- (void)showShareViewWithShareType:(UMSocialUrlType)type andContent:(NSString *_Nullable)content andImageUrl:(NSString *_Nullable)imageString andLocaltion:(CLLocation *_Nullable)location andUrl:(NSString *_Nullable)url andMediaId:(NSInteger)mediaId andPushController:(UIViewController *_Nullable)superController Successed:(ShareSuccessed _Nullable)success Failed:(ShareFailed _Nullable)failed;

/**
 分享界面弹出方法（传图片url)

 @param type            分享类型
 @param content         分享的文本
 @param title           分享标题
 @param imageString     分享的封面UrlString
 @param location        分享的坐标
 @param url             分享的web链接
 @param mediaId         分享的mediaId
 @param superController 分享界面弹出的控制器
 */
- (void)showShareViewWithShareType:(UMSocialUrlType)type andContent:(NSString *_Nullable)content andTitle:(NSString *_Nullable)title andImageUrl:(NSString *_Nullable)imageString andLocaltion:(CLLocation *_Nullable)location andUrl:(NSString *_Nullable)url andMediaId:(NSInteger)mediaId andPushController:(UIViewController *_Nullable)superController Successed:(ShareSuccessed _Nullable)success Failed:(ShareFailed _Nullable)failed;

- (void)hidZfShareView;

@end
