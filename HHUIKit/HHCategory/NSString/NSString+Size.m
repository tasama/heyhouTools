//
//  NSString+Size.m
//  AFNetworking
//
//  Created by xheng on 3/11/17.
//

#import "NSString+Size.h"
#import <HHFoundation/HHMarco.h>

@implementation NSString (Size)
    
- (CGFloat)stringHeightWithFont:(UIFont *)font width:(CGFloat)width {
    if (kStringIsEmpty(self))
    {
        return 0.0;
    }
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
    return rect.size.height;
}
    
- (CGFloat)stringWidthWithFont:(UIFont *)font height:(CGFloat)height {
    if (kStringIsEmpty(self))
    {
        return 0.0;
    }
    CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
    return rect.size.width;
}
    
@end
