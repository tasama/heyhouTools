//
//  UIImageView+AdaptiveImage.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 2017/3/20.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import "UIImageView+AdaptiveImage.h"
#import <UIImageView+WebCache.h>
#import <SDWebImageManager.h>
#import <objc/runtime.h>


@implementation UIImageView (AdaptiveImage)

+ (void)hookSDWebImage {
    
    Method originMethod = class_getInstanceMethod(self, @selector(sd_setImageWithURL:placeholderImage:options:progress:completed:));
    Method hookMethod = class_getInstanceMethod(self, @selector(hh_setImageWithURL:placeholderImage:options:progress:completed:));
    
    method_exchangeImplementations(originMethod, hookMethod);
    
}

- (void)hh_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock {
    
    NSURL *hookURL = url;
    
    //适配图片，拼接对应尺寸
    
    
    [self hh_setImageWithURL:hookURL placeholderImage:placeholder options:options progress:progressBlock completed:completedBlock];
}



@end
