//
//  HHGlobalVariable.h
//  FunnyTicket
//
//  Created by Xun on 17/4/19.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HHFoundation/HHDefines.h>

/// 屏幕宽高
HH_EXTERN float HHScreenWidth;

HH_EXTERN float HHScreenHeight;

/// 基础屏幕宽高（UI设计时使用宽高）
HH_EXTERN const float HHBasicScreenWidth;

HH_EXTERN const float HHBasicScreenHeight;

/// 实际屏幕与UI实际时屏幕大小比例
HH_EXTERN float HHScreenScale;

CG_INLINE CGFloat adaptScreenNum(float num) {
    
    if (fabsf(num * HHScreenScale) < 1) {
        
        return num;
    }
    return (int)(num * HHScreenScale);
}

CG_INLINE CGRect HHRectMake(float x, float y, float width, float height) {
    
    CGRect rect;
    rect.origin.x = adaptScreenNum(x); rect.origin.y = adaptScreenNum(y);
    rect.size.width = adaptScreenNum(width); rect.size.height = adaptScreenNum(height);
    
    return rect;
}

CG_INLINE UIEdgeInsets HHEdgeInsetsMake(float top, float left, float bottom, float right) {
    
    UIEdgeInsets insets;
    insets.top = adaptScreenNum(top); insets.left = adaptScreenNum(left);
    insets.bottom = adaptScreenNum(bottom); insets.right = adaptScreenNum(right);
    
    return insets;
}

CG_INLINE CGSize HHSizeMake(float width, float height) {
    
    CGSize size; size.width = adaptScreenNum(width); size.height = adaptScreenNum(height);
    
    return size;
}

CG_INLINE CGPoint HHPointMake(float x, float y) {
    
    CGPoint point; point.x = adaptScreenNum(x); point.y = adaptScreenNum(y);
    
    return point;
}
