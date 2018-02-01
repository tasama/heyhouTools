//
//  HHShareTool.m
//  FunnyTicket
//
//  Created by tasama on 16/11/25.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "HHShareTool.h"
#import "ZFShareView.h"
#import "HHShareCoreTool.h"

#import <HHFoundation/HHFoundation.h>
#import <HHUIKit/HHUIKit.h>
#import <SDWebImageDownloader.h>

@interface HHShareTool ()<ZFShareViewDelegate>

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, strong) CLLocation *location;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, assign) UMSocialUrlType type;

@property (nonatomic, assign) NSInteger mediaId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, weak) UIViewController *superViewController;

@property (nonatomic, copy) ShareSuccessed success;

@property (nonatomic, copy) ShareFailed failed;

@property (nonatomic, weak) ZFShareView *zfShareView;

@end

@implementation HHShareTool

- (void)dealloc {
    
    NSLog(@"HHShareTool dealloc");
}

+ (instancetype)sharedInstanced {
    
    static HHShareTool *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shareInstance = [[self alloc]init];
    });
    
    return shareInstance;
}

- (void)showShareViewWithShareType:(UMSocialUrlType)type andContent:(NSString *)content andImageUrl:(NSString *)imageString andLocaltion:(CLLocation *)location andUrl:(NSString *)url andMediaId:(NSInteger)mediaId andPushController:(UIViewController *)superController Successed:(ShareSuccessed)success Failed:(ShareFailed)failed {
    
    ZFShareView *zfShareView = [[ZFShareView alloc]initWithTarget:self];
    [zfShareView show];
    
    self.type = type;
    self.content = content;
    self.success = success;
    self.failed = failed;
    self.imageUrl = imageString;
    
    
    NSRange range = [imageString rangeOfString:@"?"];
    if (range.length > 0) {
        
        imageString = [imageString substringToIndex:range.location];
    }

    imageString = [imageString stringByAppendingString:QiNiuPhotoThumbnailMinSize];
    
    kWeakSelf(self);
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageString] options:SDWebImageDownloaderHighPriority progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        
        if (finished && error == nil) {
            
            weakself.image = image;
        }
    }];
    self.location = location;
    self.url = url;
    self.mediaId = mediaId;
    self.superViewController = superController;

}

- (void)showShareViewWithShareType:(UMSocialUrlType)type andContent:(NSString *)content andImage:(UIImage *)image andLocaltion:(CLLocation *)location andUrl:(NSString *)url andMediaId:(NSInteger)mediaId andPushController:(UIViewController *)superController Successed:(ShareSuccessed)success Failed:(ShareFailed)failed{
    
    ZFShareView *zfShareView = [[ZFShareView alloc]initWithTarget:self];
    [zfShareView show];
    
    self.type = type;
    self.content = content;
    self.image = image;
    self.location = location;
    self.url = url;
    self.mediaId = mediaId;
    self.superViewController = superController;
    self.success = success;
    self.failed = failed;

}

- (void)shareView:(ZFShareView *)view didClickAtIndex:(NSInteger)buttonIndex {

    NSInteger shareType = -1;
    switch (buttonIndex)
    {//微信朋友圈	UMShareToWechatTimeline 微信	UMShareToWechatSession QQ	UMShareToQQ QQ空间	UMShareToQzone
        case 0:
        {//微信
//            [array addObject:UMShareToWechatSession];
            shareType = CoreSocialplatformTypeWechatSession;
        }
            break;
        case 1:
        {//朋友圈
            shareType = CoreSocialplatformTypeWechatTimeLine;
        }
            break;
        case 2:
        {//QQ
//            [array addObject:UMShareToQQ];
            shareType = CoreSocialplatformTypeQQ;
        }
            break;
        case 3:
        {
//            [array addObject:UMShareToQzone];
            shareType = CoreSocialplatformTypeQzone;
        }
            break;
        case 4:
        {
//            [array addObject:UMShareToSina];
            shareType = CoreSocialplatformTypeSina;
            //            [array addObject:UMShareToSina];
        }
            break;
    }
    
    if (shareType == -1) {
        
        [HHAlert showAlertString:@"分享类型为空"];
        HHLogError(@"分享类型为空");
        return;
    }
    
    
    
    NSMutableDictionary *partenter = @{}.mutableCopy;

    if (self.title) {
        
        [partenter addEntriesFromDictionary:@{kShareCoreTitle: self.title}];
    } else {
        
        [HHAlert showAlertString:@"分享标题为空"];
        HHLogError(@"分享标题为空");
        return;
    }
    if (self.content) {
        
        [partenter addEntriesFromDictionary:@{kShareCoreContent: self.content}];
    } else {
        
        [partenter addEntriesFromDictionary:@{kShareCoreContent: self.title}];
    }
    if (self.url) {
        
        [partenter addEntriesFromDictionary:@{kShareCoreUrl: self.url}];
    } else {
        
        [HHAlert showAlertString:@"分享链接为空"];
        HHLogError(@"分享链接为空");
        return;
    }
    if (self.image) {
        
        [partenter addEntriesFromDictionary:@{kShareCoreImage: self.image}];
    } else if (self.imageUrl) {
        
        [partenter addEntriesFromDictionary:@{kShareCoreImageUrl: self.imageUrl}];
    }
    
    [[HHShareCoreTool sharedHHShareCoreTool] shareWithType:shareType andMediaType:self.type andMediaId:self.mediaId andController:self.superViewController andOtherOptions:partenter.copy withComplition:^(NSError * _Nullable error) {
       
        if (!error) {
            
            [HHAlert showAlertString:@"分享成功"];

            if (self.success) {

                self.success();
            }
        } else {
            
            if (error.code == 2009) {
                
                [HHAlert showAlertString:@"取消分享"];
                
            } else {
                
                if (self.failed) {
                    
                    self.failed(error.code);
                }
            }
        }
        self.image = nil;
        self.content = nil;
        self.location = nil;
        self.url = nil;
        self.title = nil;
    } userAction:self.userSocialActionBlock];
}


- (void)showShareViewWithShareType:(UMSocialUrlType)type andContent:(NSString *)content andTitle:(NSString *)title andImageUrl:(NSString *)imageString andLocaltion:(CLLocation *)location andUrl:(NSString *)url andMediaId:(NSInteger)mediaId andPushController:(UIViewController *)superController Successed:(ShareSuccessed)success Failed:(ShareFailed)failed{
    
    ZFShareView *zfShareView = [[ZFShareView alloc]initWithTarget:self];
    [zfShareView show];
    self.zfShareView = zfShareView;
    
    self.type = type;
    self.content = content;
    self.title = title;
    self.success = success;
    self.failed = failed;
    self.imageUrl = imageString;
    
    kWeakSelf(self);
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageString] options:SDWebImageDownloaderHighPriority progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        
        if (finished && error == nil) {
            
            weakself.image = image;
        }
    }];
    self.location = location;
    self.url = url;
    self.mediaId = mediaId;
    self.superViewController = superController;
}

- (void)hidZfShareView
{
    [self.zfShareView hide];
}

@end
