//
//  UIImage+HHScreenshot.m
//  FunnyTicket
//
//  Created by Xun on 17/6/5.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "UIImage+HHScreenshot.h"

@implementation UIImage (HHScreenshot)

+ (UIImage *)imagewWithFrameOnScreen:(CGRect)frame {
    
    //UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    CGRect rect = [UIScreen mainScreen].bounds;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    CGSize imageSize = CGSizeZero;
    //CGFloat width = rect.size.width, height = rect.size.height;
    CGFloat x = rect.origin.x, y = rect.origin.y;
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, keyWindow.center.x, keyWindow.center.y);
    CGContextConcatCTM(context, keyWindow.transform);
    CGContextTranslateCTM(context, -keyWindow.bounds.size.width * keyWindow.layer.anchorPoint.x, -keyWindow.bounds.size.height * keyWindow.layer.anchorPoint.y);
    
    CGContextTranslateCTM(context, -x, -y);
    
    if([keyWindow respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        [keyWindow drawViewHierarchyInRect:keyWindow.bounds afterScreenUpdates:NO];
    else
        [keyWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    CGContextRestoreGState(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)rh_imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    
    //把像 素rect 转化为 点rect（如无转化则按原图像素取部分图片）
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat x= rect.origin.x*scale,y=rect.origin.y*scale,w=rect.size.width*scale,h=rect.size.height*scale;
    CGRect dianRect = CGRectMake(x, y, w, h);
    
    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    return newImage;
}

@end
