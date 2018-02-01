//
//  \\      //     ||          ||     ||\        ||
//   \\    //      ||          ||     ||\\       ||
//    \\  //       ||          ||     || \\      ||
//     \\//        ||          ||     ||  \\     ||
//      /\         ||          ||     ||   \\    ||
//     //\\        ||          ||     ||    \\   ||
//    //  \\       ||          ||     ||     \\  ||
//   //    \\      ||          ||     ||      \\ ||
//  //      \\      \\        //      ||       \\||
// //        \\      \\======//       ||        \||
//
//
//  NSString+AttributedString.h
//  ProjectKit
//
//  Created by xun on 16/12/12.
//  Copyright © 2016年 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 出现的位置，0代表第一次出现的始位置，-1代表最后一次出现的位置*/
typedef NSInteger OccurrenceIndex;

@interface NSString (AttributedString)

@property (nonatomic, readonly) NSMutableAttributedString *xun_attributedText;

#pragma mark - 标记1 下一标记之上所有函数，均可参照此注释
/**
 *  设置在该字符串中，第index次出现的子字符串颜色、字体
 *
 *  @param substring 子字符串
 *  @param font      字体
 *  @param color     颜色
 *  @param index     下标
 */
- (void)setSubstring:(NSString *)substring
                font:(UIFont *)font
               color:(UIColor *)color
             atIndex:(OccurrenceIndex)index;
- (void)setSubstring:(NSString *)substring
               color:(UIColor *)color
             atIndex:(OccurrenceIndex)index;
- (void)setSubstring:(NSString *)substring
                font:(UIFont *)font
             atIndex:(OccurrenceIndex)index;
- (void)setSubstring:(NSString *)substring
               color:(UIColor *)color;
- (void)setSubstring:(NSString *)substring
                font:(UIFont *)font;
- (void)setSubstring:(NSString *)substring
                font:(UIFont *)font
               color:(UIColor *)color;


/**
 *  设置字符串的颜色和字体
 *
 *  @param color 颜色
 *  @param font 字体
 */
- (void)setColor:(UIColor *)color
            font:(UIFont *)font;
- (void)setColor:(UIColor *)color;
- (void)setFont:(UIFont *)font;

#pragma mark - Styles

/**
 *  设置子字符串样式
 *
 *  @param substring 子字符串
 *  @param styles    样式
 *  @param index     下标
 */
- (void)setSubstring:(NSString *)substring
              styles:(NSDictionary *)styles
             atIndex:(OccurrenceIndex)index;
/**
 *  设置多串子字符串样式（默认第一次出现）
 *
 *  @param substrings 子字符串数组
 *  @param styles     样式
 */
- (void)setSubstrings:(NSArray *)substrings
               styles:(NSDictionary *)styles;

/**
 *  设置所有相同子字符串样式
 *
 *  @param subString 子字符串
 *  @param styles    样式
 */
- (void)setAllSameSubString:(NSString *)subString
                     styles:(NSDictionary *)styles;

#pragma mark - 线条
- (void)addUnderlineForSubstring:(NSString *)substring;
- (void)addMidlineForSubstring:(NSString *)substring;

#pragma mark - 间距

/**
 *  设置文本段落及行间距
 *
 *  @param pSpace 段落间距
 *  @param lSpace 行间距
 *  @param style  段落样式
 */
- (void)setParagraphSpace:(CGFloat)pSpace
                lineSpace:(CGFloat)lSpace
           paragraphStyle:(NSMutableParagraphStyle **)style;
- (void)setParagraphSpace:(CGFloat)pSpace
                lineSpace:(CGFloat)lSpace;
- (void)setLineSpace:(CGFloat)space;
- (void)setWordSpace:(CGFloat)space;

- (void)setParagraphStyle:(NSParagraphStyle *)style;


/**
 *  插入图片(需要等我完善)
 *
 *  @param image    图片
 *  @param index    位置
 *  @param bounds   大小
 */
- (void)insertImage:(UIImage *)image
            atIndex:(NSInteger)index
             bounds:(CGRect)bounds NS_UNAVAILABLE;

@end
