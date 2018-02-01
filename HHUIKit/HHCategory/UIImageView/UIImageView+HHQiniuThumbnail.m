//
//  UIImageView+HHQiniuThumbnail.m
//  PersonShow
//
//  Created by heyhou on 17/3/20.
//  Copyright © 2017年 Jude. All rights reserved.
//

#import "UIImageView+HHQiniuThumbnail.h"
#import <HHFoundation/NSURL+HHQiniuThumbnail.h>
#import <UIImageView+WebCache.h>
#import <SDWebImageDownloader.h>
#import <UIImage+BlurEffects.h>
#import <objc/runtime.h>

static char imageURLKey;
static char placeholderKey;
static char lastFrameKey;

#define HHThumbnail 0

@implementation UIImageView (HHQiniuThumbnail)

- (void)hh_setImageWithURL:(NSURL *)url {
    self.imgUrl = url;
    if (url.absoluteString.length == 0 || !url) {
        return;
    }
    if (!HHThumbnail) {
        if (self.frame.size.width) {
            [self sd_setImageWithURL:[url thumbnailUrl:self.frame] placeholderImage:nil options:0 progress:nil completed:nil];
        }
    } else {
        [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:nil];
    }
}

- (void)hh_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    self.imgUrl = url;
    self.placeholder = placeholder;
    if (url.absoluteString.length == 0 || !url) {
        self.image = placeholder;
        return;
    }
    if (!HHThumbnail) {
        if (self.frame.size.width) {
            [self sd_setImageWithURL:[url thumbnailUrl:self.frame] placeholderImage:placeholder options:0 progress:nil completed:nil];
        }
    } else {
            [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:nil];
    }
}
    
- (void)hh_setBlurImageWithURL:(NSURL *)url withRadius:(CGFloat)radius placeholderImage:(UIImage *)placeholder {
    
    NSString *absoluStr = url.absoluteString;
    if ([absoluStr rangeOfString:@"imageMogr2"].location == NSNotFound) {
    
        absoluStr = [NSString stringWithFormat:@"%@?imageMogr2/auto-orient/thumbnail/100x", absoluStr];
    }
    
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:absoluStr] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (!error) {
                
                self.image = [UIImage ty_imageByApplyingBlurToImage:image withRadius:radius tintColor:nil saturationDeltaFactor:1.0f maskImage:nil];
            } else {
                
                self.image = [UIImage ty_imageByApplyingBlurToImage:placeholder withRadius:radius tintColor:nil saturationDeltaFactor:1.0f maskImage:nil];
            }
        });
    }];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if(!CGRectEqualToRect(frame, self.lastFrame) )
    {
        self.lastFrame = frame;
        if (self.imgUrl && !HHThumbnail) {
            [self sd_setImageWithURL:[self.imgUrl thumbnailUrl:self.frame] placeholderImage:self.placeholder options:0 progress:nil completed:nil];
        }
    }
}

- (void)setImgUrl:(NSURL *)imgUrl
{
    objc_setAssociatedObject(self, &imageURLKey, imgUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSURL *)imgUrl
{
    return objc_getAssociatedObject(self, &imageURLKey);
}

- (void)setPlaceholder:(UIImage *)placeholder
{
     objc_setAssociatedObject(self, &placeholderKey, placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)placeholder
{
    return objc_getAssociatedObject(self, &placeholderKey);
}

- (void)setLastFrame:(CGRect)lastFrame
{
    objc_setAssociatedObject(self, &lastFrameKey, [NSValue valueWithCGRect:lastFrame], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)lastFrame
{
     return [objc_getAssociatedObject(self, &lastFrameKey) CGRectValue];
}

@end
