//
//  UILabel+ChangeLineSpaceAndWordSpace.h
//  FunnyTicket
//
//  Created by tasama on 17/6/13.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ChangeLineSpaceAndWordSpace)


/**
 给label赋值，并赋予行间距

 @param text      文字
 @param lineSpace 文字行距
 */
- (void)setText:(NSString *)text withLineSpace:(CGFloat)lineSpace;

@end
