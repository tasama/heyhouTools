//
//  UIImageView+HHQiniuThumbnail.h
//  PersonShow
//
//  Created by heyhou on 17/3/20.
//  Copyright © 2017年 Jude. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (HHQiniuThumbnail)
@property NSURL   *imgUrl;
@property UIImage *placeholder;
@property CGRect  lastFrame;
- (void)hh_setImageWithURL:(NSURL *)url;
- (void)hh_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
- (void)hh_setBlurImageWithURL:(NSURL *)url withRadius:(CGFloat)radius placeholderImage:(UIImage *)placeholder;
@end
