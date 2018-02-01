//
//  UIButton+Extrence.h
//  FunnyTicket
//
//  Created by heyhou on 16/12/6.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extrence)

- (void)NaVbuttonLetf:(NSString *)url;

- (void)NaVbuttonRight:(NSString *)url;

//给按钮添加图片
- (void)ButtonAddWithImagView:(NSString *)url;

/*
 *  给button 订制圆圈  颜色 主题色 宽 3
 */
- (void)ButtonAddCirce;

/*
 *  定制imageView
 */
- (void)ButtonAddImageViewActivityUI:(NSString *)url;

@end
