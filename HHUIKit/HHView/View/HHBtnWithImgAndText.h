//
//  HHBtnWithImgAndText.h
//  FunnyTicket
//
//  Created by tasama on 17/4/12.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    HHBtnWithImgAndTextContentTypeLeft,
    HHBtnWithImgAndTextContentTypeRight,
    HHBtnWithImgAndTextContentTypeCenter
    
}HHBtnWithImgAndTextContentType;

@interface HHBtnWithImgAndText : UIButton

@property (nonatomic, assign) HHBtnWithImgAndTextContentType myContentType;

- (CGSize)getBtnSizeWithTitle:(NSString *)title andFont:(UIFont *)font;

- (CGSize)getBtnSizeWithNum:(NSInteger)num andFont:(UIFont *)font;

- (CGSize)getBtnSizeWithNum:(NSInteger)num andFont:(UIFont *)font andPlaceHolder:(NSString *)placeholder;

@end
