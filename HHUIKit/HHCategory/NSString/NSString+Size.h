//
//  NSString+Size.h
//  AFNetworking
//
//  Created by xheng on 3/11/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Size)
    
- (CGFloat)stringHeightWithFont:(UIFont *)font width:(CGFloat)width;
    
- (CGFloat)stringWidthWithFont:(UIFont *)font height:(CGFloat)height;

@end
