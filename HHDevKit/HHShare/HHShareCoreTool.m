//
//  HHShareCoreTool.m
//  FunnyTicket
//
//  Created by tasama on 17/5/2.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHShareCoreTool.h"
#import <SDWebImageDownloader.h>
#import <HHUIKit/HHUIKit.h>
#import <HHFoundation/HHFoundation.h>

@interface HHShareCoreTool ()

@property (nonatomic, strong) UIViewController *superViewController;

@end

@implementation HHShareCoreTool
single_implementation(HHShareCoreTool)

- (void)shareWithType:(CoreSocialplatformType)shareType andMediaType:(CoreSocialUrlType)type andMediaId:(NSInteger)mediaId andController:(UIViewController *)controller andOtherOptions:(NSDictionary *)option withComplition:(ShareComplition)complitionBlock userAction:(void (^)(NSInteger mediaID, NSInteger mediaType))action{
    
    
    UIViewController *vc = controller;
    do {
        if (!vc)
            
            break;
        if (vc.navigationController) {
            break;
        }
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController *)vc).selectedViewController;
            if ([vc isKindOfClass:[HHNavigationController class]]) {
                
                vc = [vc.childViewControllers lastObject];
                break;
            }
        }
        
        if (vc.presentingViewController.navigationController) {
            vc = vc.presentingViewController;
            break;
        } else {
            vc = vc.presentingViewController;
        }
    } while(TRUE);
    
    if (kObjectIsEmpty(vc)) {
     
        [HHAlert showAlertString:@"当前的控制器不存在"];
        HHLogError(@"当前的控制器不存在");
        return;
    }

    self.superViewController = vc;
    
    NSString *title = option[kShareCoreTitle];
    NSString *content = option[kShareCoreContent];
    __block UIImage *localImage = option[kShareCoreImage];
    NSString *imageUrlString = option[kShareCoreImageUrl];
    NSString *shareUrl = option[kShareCoreUrl];
    
    if (kStringIsEmpty(shareUrl)) {
        
        [HHAlert showAlertString:@"分享链接为空"];
        HHLogError(@"分享链接为空");
        return;
    }

    if (kStringIsEmpty(title)) {
        
        [HHAlert showAlertString:@"分享标题为空"];
        HHLogError(@"分享标题为空");
        return;
    }

    if (kStringIsEmpty(content)) {
        
        content = title;
    }
    
    if (!kStringIsEmpty(imageUrlString)) {
        
        imageUrlString = [imageUrlString stringByAppendingString:QiNiuPhotoThumbnailMediumSize];
        [controller showHudInView:controller.view hint:@""];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageUrlString] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
           
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [controller hideHud];
                if (finished && !error) {
                    
                    localImage = image;
                    
                    [self shareAcitonWithTitle:title andContent:content andImage:localImage andShareUrl:shareUrl andShareType:shareType andMediaId:mediaId andMediaType:type andController:controller andComplition:complitionBlock userAction:action];
                     
                } else {
                    
                    localImage = HeadPlaceholderImage;
                    [self shareAcitonWithTitle:title andContent:content andImage:localImage andShareUrl:shareUrl andShareType:shareType andMediaId:mediaId andMediaType:type andController:controller andComplition:complitionBlock userAction:action];
                }
            });
        }];
    } else if (!kObjectIsEmpty(localImage)) {
        
        [self shareAcitonWithTitle:title andContent:content andImage:localImage andShareUrl:shareUrl andShareType:shareType andMediaId:mediaId andMediaType:type andController:controller andComplition:complitionBlock userAction:action];
    } else {
        
        [self shareAcitonWithTitle:title andContent:content andImage:HeadPlaceholderImage andShareUrl:shareUrl andShareType:shareType andMediaId:mediaId  andMediaType:type andController:controller andComplition:complitionBlock userAction:action];
    }
}

- (void)shareAcitonWithTitle:(NSString *)title andContent:(NSString *)content andImage:(UIImage *)image andShareUrl:(NSString *)shareUrl andShareType:(CoreSocialplatformType)shareType andMediaId:(NSInteger)mediaId andMediaType:(NSInteger)mediaType andController:(UIViewController *)controller andComplition:(ShareComplition)finishBlock userAction:(void (^)(NSInteger mediaID, NSInteger mediaType))action{
    
//    NSMutableArray *array = [NSMutableArray array];
//    
    NSInteger platformType = -1 ;
    if (shareType == CoreSocialplatformTypeQQ) {
        
        platformType = UMSocialPlatformType_QQ;
    } else if (shareType == CoreSocialplatformTypeQzone) {
        
        platformType = UMSocialPlatformType_Qzone;
    } else if (shareType == CoreSocialplatformTypeWechatSession) {
        
        platformType = UMSocialPlatformType_WechatSession;
    } else if (shareType == CoreSocialplatformTypeWechatTimeLine) {
        
        platformType = UMSocialPlatformType_WechatTimeLine;
    } else if (shareType == CoreSocialplatformTypeSina) {
        
        platformType = UMSocialPlatformType_Sina;
    } else {

        [HHAlert showAlertString:@"分享类型不存在"];
        HHLogError(@"分享类型错误");
        return;
    }
    
    if (content.length > 200) {
        
        content = [content substringToIndex:200];
    }
    
    if (title.length > 200) {
        
        [title substringToIndex:200];
    }
    
    if (platformType == UMSocialPlatformType_Sina) {
        
        NSRange range = [title rangeOfString:@"@嘿吼"];
        if (range.location == NSNotFound) {
            
            title = [title stringByAppendingString:@"@嘿吼"];
        }
    }
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareWebpageObject *webObject = [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:image];
    
    webObject.webpageUrl = shareUrl;
    
    messageObject.shareObject = webObject;

    if (platformType == UMSocialPlatformType_Sina) {
        
        BOOL reuslt = [HHUMLoginCoreTool getTypeInstall:UMSocialPlatformType_Sina];
        if (!reuslt) {
            
            [HHAlert showAlertString:@"未安装相关客户端"];
            return;
        }
    }
//
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:controller completion:^(id result, NSError *error) {
        
        if (!error) {
            
            if (mediaType != -1 && mediaType != CoreSocialUrlTypeDefault) {
                if (action) {
                    action(mediaId, mediaType);
                }
            }
            
            if (finishBlock) {
                
                finishBlock(nil);
            }
        }
        else
        {
            if (error.code == 2008) {
                
                [HHAlert showAlertString:@"未安装相关客户端"];
            } else if (finishBlock) {
                
                finishBlock(error);
            }
        }
    }];
}

@end

@implementation HHUMLoginCoreTool

+ (void)getUserInfoForPlatform:(CoreSocialplatformType)shareType superVC:(UIViewController *)vc withComplited:(UMLoginComplition)complitionBlock {
    
    UMSocialPlatformType platformType = -1;
    if (shareType == CoreSocialplatformTypeQQ) {
        
        platformType = UMSocialPlatformType_QQ;
    } else if (shareType == CoreSocialplatformTypeQzone) {
        
        platformType = UMSocialPlatformType_Qzone;
    } else if (shareType == CoreSocialplatformTypeWechatSession) {
        
        platformType = UMSocialPlatformType_WechatSession;
    } else if (shareType == CoreSocialplatformTypeWechatTimeLine) {
        
        platformType = UMSocialPlatformType_WechatTimeLine;
    } else if (shareType == CoreSocialplatformTypeSina) {
        
        platformType = UMSocialPlatformType_Sina;
    } else {
        
        [HHAlert showAlertString:@"第三方登录类型错误"];
        HHLogError(@"第三方登录类型错误");
        return;
    }
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:vc completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (complitionBlock) {
                
                if (!error) {
                    
                    complitionBlock(nil, resp);
                } else {
                    
                    complitionBlock(error, nil);
                }
            }
        });
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.gender);
        
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
    }];
}

+ (BOOL)getTypeInstall:(CoreSocialplatformType)type {
    
    UMSocialPlatformType platformType = -1;
    if (type == CoreSocialplatformTypeQQ) {
        
        platformType = UMSocialPlatformType_QQ;
    } else if (type == CoreSocialplatformTypeQzone) {
        
        platformType = UMSocialPlatformType_Qzone;
    } else if (type == CoreSocialplatformTypeWechatSession) {
        
        platformType = UMSocialPlatformType_WechatSession;
    } else if (type == CoreSocialplatformTypeWechatTimeLine) {
        
        platformType = UMSocialPlatformType_WechatTimeLine;
    } else if (type = CoreSocialplatformTypeSina) {
        
        platformType = UMSocialPlatformType_Sina;
    } else {
        
        HHLogError(@"不包含检测此种第三方平台的SDK");
        return NO;
    }

    return [[UMSocialManager defaultManager] isInstall:platformType];
}

@end
