//
//  UIImage+ZFUtil.m
//  HHUIKit
//
//  Created by xheng on 3/11/17.
//

#import "UIImage+Create.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (Create)

+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
    NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    //CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}
    
+ (UIImage *)compressImage:(UIImage *)image toScaleSize:(CGSize)size
    {
        if (size.width >= image.size.width || size.height >= image.size.height)
        {
            return image;
        }
        
        CGFloat zWidth =  size.width / image.size.width;
        CGFloat zHeight = size.height / image.size.height;
        CGFloat zoom = MIN(zWidth, zHeight);
        CGSize drawSize = CGSizeMake(image.size.width * zoom, image.size.height * zoom);
        
        UIGraphicsBeginImageContext(drawSize);
        [image drawInRect:CGRectMake(0, 0, drawSize.width, drawSize.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
    
+ (UIImage *)squareImageFromImage:(UIImage *)image
    {
        UIImage *squareImage = nil;
        CGSize imageSize = [image size];
        
        if (imageSize.width == imageSize.height)
        {
            squareImage = image;
        }
        else
        {
            // Compute square crop rect
            CGFloat smallerDimension = MIN(imageSize.width, imageSize.height);
            CGRect cropRect = CGRectMake(0, 0, smallerDimension, smallerDimension);
            
            // Center the crop rect either vertically or horizontally, depending on which dimension is smaller
            if (imageSize.width <= imageSize.height)
            {
                cropRect.origin = CGPointMake(0, rintf((imageSize.height - smallerDimension) / 2.0));
            }
            else
            {
                cropRect.origin = CGPointMake(rintf((imageSize.width - smallerDimension) / 2.0), 0);
            }
            
            CGImageRef croppedImageRef = CGImageCreateWithImageInRect([image CGImage], cropRect);
            squareImage = [UIImage imageWithCGImage:croppedImageRef];
            CGImageRelease(croppedImageRef);
        }
        
        return squareImage;
    }
    
+ (UIImage *)getStarImage:(NSInteger)starLevel{
    NSString *string = @"star_level_1";
    if (starLevel < 10 && starLevel > 0) {
        string = [NSString stringWithFormat:@"star_level_%zd",starLevel];
    }
    return [UIImage imageNamed:string];
}
    
+ (UIImage *)getMasterImage:(NSInteger)masterLevel{
    NSString *string = @"master_level_d";
    NSArray *array = @[@"d",@"c",@"b",@"a",@"s"];
    if (masterLevel > 0 && masterLevel <= array.count) {
        string = [NSString stringWithFormat:@"master_level_%@",array[masterLevel - 1]];
    }
    return [UIImage imageNamed:string];
}
    
+ (UIImage *)getVIPImage:(NSInteger)vipLevel{
    NSString *string = [NSString stringWithFormat:@"vip_level_%zd",vipLevel];
    return [UIImage imageNamed:string];
}
    
@end
