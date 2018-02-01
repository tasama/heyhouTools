//
//  UIView+leftVIew.m
//  FunnyTicket
//
//  Created by tasama on 17/1/18.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import "UIView+leftVIew.h"

@implementation UIView (leftVIew)

+ (UIView *)leftView {
    
    UIView *view = [[UIView alloc] init];
    [view setFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
    image.contentMode = UIViewContentModeScaleAspectFit;
    [image setFrame:CGRectMake(8, 7.5, 15, 15)];
    [view addSubview:image];
    return view;
}

+ (UIView *)rightCountViewWithLimit:(NSInteger)limit {
    
    HHInputTextCountView *input = [[HHInputTextCountView alloc] init];
    input.numOfLimit = limit;
    [input setFrame:CGRectMake(0, 0, 60, 30)];

    return input;
}

@end
