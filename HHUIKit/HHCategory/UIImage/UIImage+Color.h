//
//  UIImage+Color.h
//  FunnyTicket
//
//  Created by tasama on 16/10/12.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

- (UIImage *)imageWithImage:(UIImage*)image
               scaledToSize:(CGSize)newSize;

- (UIImage *)currentScreenImage;

+ (UIImage*) imageWithColor:(UIColor*)color;

+ (UIImage *)handleImage:(UIImage *)originalImage withSize:(CGSize)size;



@end
