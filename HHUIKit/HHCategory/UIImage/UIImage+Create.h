//
//  UIImage+ZFUtil.h
//  HHUIKit
//
//  Created by xheng on 3/11/17.
//

#import <UIKit/UIKit.h>

@interface UIImage (Create)
    
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;//毛玻璃效果
    //压缩图片
+ (UIImage *)compressImage:(UIImage *)image toScaleSize:(CGSize)size;
    //获取正方形图片
+ (UIImage *)squareImageFromImage:(UIImage *)image;
    //获取厂牌图标
+ (UIImage *)getStarImage:(NSInteger)starLevel;
    //获取达人图标
+ (UIImage *)getMasterImage:(NSInteger)masterLevel;
    //获取vip图标
+ (UIImage *)getVIPImage:(NSInteger)vipLevel;

@end
