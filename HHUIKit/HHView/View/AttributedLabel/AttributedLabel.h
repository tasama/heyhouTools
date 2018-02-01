//
//  AttributedLabel.h
//  AttributedStringTest
//
//  Created by sun huayu on 13-2-19.
//  Copyright (c) 2013年 sun huayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>

@interface AttributedLabel : UILabel{
    NSMutableAttributedString          *_attString;
}

/*
 Alignment modes.
 
 CA_EXTERN NSString * const kCAAlignmentNatural
 __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_3_2);
 CA_EXTERN NSString * const kCAAlignmentLeft
 __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_3_2);
 CA_EXTERN NSString * const kCAAlignmentRight
 __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_3_2);
 CA_EXTERN NSString * const kCAAlignmentCenter
 __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_3_2);
 CA_EXTERN NSString * const kCAAlignmentJustified
 __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_3_2);
 */
@property (nonatomic, strong) NSString *textlayerAlignment;

// 设置某段字的颜色
- (void)setColor:(UIColor *)color fromIndex:(NSInteger)location length:(NSInteger)length;

// 设置某段字的字体
- (void)setFont:(UIFont *)font fromIndex:(NSInteger)location length:(NSInteger)length;

// 设置某段字的风格
- (void)setStyle:(CTUnderlineStyle)style fromIndex:(NSInteger)location length:(NSInteger)length;

@end
