//
//  UIImageView+ZFUtil.m
//  HHUIKit
//
//  Created by xheng on 3/11/17.
//

#import "UIImageView+PlaceHolder.h"

@implementation UIImageView (PlaceHolder)
    
+ (UIImageView *)imageViewWithPlaceholderImage:(UIImage *)image
    {
        UIImageView *iv = [[UIImageView alloc] init];
        [iv setImage:image];
        return iv;
    }


@end
