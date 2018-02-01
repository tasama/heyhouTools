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
//  NSString+AttributedString.m
//  ProjectKit
//
//  Created by xun on 16/12/12.
//  Copyright © 2016年 Xun. All rights reserved.
//

#import "NSString+AttributedString.h"
#import <CoreText/CoreText.h>
#import <objc/runtime.h>

#define kAssociationKey "ATTRIBUTED_STRING_KEY"

@implementation NSString (AttributedString)

- (void)setSubstring:(NSString *)substring
                font:(UIFont *)font
{
    [self setSubstring:substring font:font atIndex:0];
}

- (void)setSubstring:(NSString *)substring
                font:(UIFont *)font
             atIndex:(OccurrenceIndex)index
{
    [self setSubstring:substring font:font color:nil atIndex:index];
}

- (void)setSubstring:(NSString *)substring
               color:(UIColor *)color
{
    [self setSubstring:substring color:color atIndex:0];
}

- (void)setSubstring:(NSString *)substring
               color:(UIColor *)color
             atIndex:(OccurrenceIndex)index
{
    [self setSubstring:substring font:nil color:color atIndex:index];
}

- (void)setSubstring:(NSString *)substring
                font:(UIFont *)font
               color:(UIColor *)color
{
    [self setSubstring:substring font:font color:color atIndex:0];
}

- (void)setSubstring:(NSString *)substring
                font:(UIFont *)font
               color:(UIColor *)color
             atIndex:(OccurrenceIndex)index
{
    if (!substring || !substring.length)
    {
        return;
    }
    
    NSRange range = NSMakeRange(0, 0);
    
    if (index == 0)
    {
        range = [self rangeOfString:substring];
        
        !color ? :[self.xun_attributedText addAttributes:@{NSForegroundColorAttributeName:color} range:range];
        !font ? :[self.xun_attributedText addAttributes:@{NSFontAttributeName:font} range:range];
    }
    else if (index == -1)
    {
        range = [self rangeOfString:substring options:NSBackwardsSearch];
        
        !color ? :[self.xun_attributedText addAttributes:@{NSForegroundColorAttributeName:color} range:range];
        !font ? :[self.xun_attributedText addAttributes:@{NSFontAttributeName:font} range:range];
    }
    else
    {
        for (int i = 0; i < index; i++)
        {
            range = [self rangeOfString:substring options:0 range:NSMakeRange(range.length + range.location, self.length - range.length - range.location - 1)];
            
            !color ? :[self.xun_attributedText addAttributes:@{NSForegroundColorAttributeName:color} range:range];
            !font ? :[self.xun_attributedText addAttributes:@{NSFontAttributeName:font} range:range];
        }
    }
}

- (void)setColor:(UIColor *)color font:(UIFont *)font {
    
    NSRange range = NSMakeRange(0, self.length);
    
    !color ? :[self.xun_attributedText addAttributes:@{NSForegroundColorAttributeName:color} range:range];
    !font ? :[self.xun_attributedText addAttributes:@{NSFontAttributeName:font} range:range];
}

- (void)setColor:(UIColor *)color {
    
    [self setColor:color font:nil];
}

- (void)setFont:(UIFont *)font {
    
    [self setColor:nil font:font];
}

#pragma mark - Styles

- (void)setSubstring:(NSString *)substring
              styles:(NSDictionary *)styles
             atIndex:(OccurrenceIndex)index
{
    if (!substring || !substring.length)
    {
        return;
    }
    
    [self.xun_attributedText addAttributes:styles range:[self rangeOfSubstring:substring occurrenceIndex:index]];
}

- (void)setAllSameSubString:(NSString *)subString
                     styles:(NSDictionary *)styles
{
    NSRange range = [self rangeOfString:subString];
    
    NSMutableArray *rangeArr = [NSMutableArray new];
    
    while (range.location != NSNotFound)
    {
        [rangeArr addObject:[NSValue valueWithRange:range]];
        
        range = [self rangeOfString:subString options:0 range:NSMakeRange(range.location + range.length, self.length - range.location - range.length)];
    }
    
    for (NSValue *value in rangeArr)
    {
        [self.xun_attributedText addAttributes:styles range:value.rangeValue];
    }
}

- (void)setSubstrings:(NSArray *)substrings
               styles:(NSDictionary *)styles
{
    for (NSString *sub in substrings)
    {
        [self setSubstring:sub styles:styles atIndex:0];
    }
}

#pragma mark - 间距

- (void)setLineSpace:(CGFloat)space
{
    [self setParagraphSpace:space lineSpace:space];
}

- (void)setParagraphSpace:(CGFloat)pSpace lineSpace:(CGFloat)lSpace
{
    [self setParagraphSpace:pSpace lineSpace:lSpace paragraphStyle:NULL];
}

- (void)setParagraphSpace:(CGFloat)pSpace lineSpace:(CGFloat)lSpace paragraphStyle:(NSMutableParagraphStyle *__autoreleasing *)style {
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = lSpace / 2;
    paragraphStyle.paragraphSpacing = pSpace / 2;
    [self.xun_attributedText addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, self.length)];
    
    if (style) *style = paragraphStyle;
}

- (void)setWordSpace:(CGFloat)space
{
    [self.xun_attributedText addAttributes:@{(id)kCTKernAttributeName:@(space)} range:NSMakeRange(0, self.length)];
}

- (void)setParagraphStyle:(NSParagraphStyle *)style {
    
    [self.xun_attributedText addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.length)];
}

#pragma mark - 线条

- (void)addUnderlineForSubstring:(NSString *)substring
{
    if (!substring || substring.length)
    {
        return;
    }
    
    [self.xun_attributedText addAttributes:@{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:[self rangeOfString:substring]];
}

- (void)addMidlineForSubstring:(NSString *)substring
{
    if (!substring || substring.length)
    {
        return;
    }
    
    [self.xun_attributedText addAttributes:@{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:[self rangeOfString:substring]];
}

#pragma mark - 图片

- (void)insertImage:(UIImage *)image
            atIndex:(NSInteger)index
             bounds:(CGRect)bounds {
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = image;
    textAttachment.bounds = bounds;
    
    NSAttributedString *imageAS = [NSAttributedString attributedStringWithAttachment:textAttachment];
    
    [self.xun_attributedText insertAttributedString:imageAS atIndex:index];
}

#pragma mark - Private Method

- (NSRange)rangeOfSubstring:(NSString *)substring
            occurrenceIndex:(OccurrenceIndex)index
{
    NSRange range;
    
    if (index == 0)
    {
        range = [self rangeOfString:substring];
    }
    else if (index == -1)
    {
        range = [self rangeOfString:substring options:NSBackwardsSearch];
    }
    else
    {
        range = NSMakeRange(0, 0);
        for (int i = 0; i < index; i++)
        {
            range = [self rangeOfString:substring options:0 range:NSMakeRange(range.length + range.location, self.length - range.length - range.location)];
        }
    }
    return range;
}

- (NSMutableAttributedString *)xun_attributedText
{
    NSMutableAttributedString *attrString = objc_getAssociatedObject(self, kAssociationKey);
    
    if (!attrString ||
        ![attrString.string isEqualToString:self])
    {
        objc_removeAssociatedObjects(self);
        
        attrString = [[NSMutableAttributedString alloc] initWithString:self];
        
        objc_setAssociatedObject(self, kAssociationKey, attrString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return attrString;
}

@end
