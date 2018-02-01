//
//  UIButton+Extrence.m
//  FunnyTicket
//
//  Created by heyhou on 16/12/6.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "UIButton+Extrence.h"
#import "Masonry.h"
#import "UIColor+Hex.h"
#import "UIView+Frame.h"
#import "HHUIConst.h"

@implementation UIButton (Extrence)


- (void)NaVbuttonLetf:(NSString *)url{
    UIImageView *btnIamgeView = [[UIImageView alloc] init];
    
    btnIamgeView.image = [UIImage imageNamed:url];
    
    [self addSubview:btnIamgeView];
    
    [btnIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@14);
        make.width.equalTo(@14);
    }];

}

- (void)NaVbuttonRight:(NSString *)url{
    UIImageView *btnIamgeView = [[UIImageView alloc] init];
    
    btnIamgeView.image = [UIImage imageNamed:url];
    
    [self addSubview:btnIamgeView];
    
    [btnIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@28);
        make.width.equalTo(@14);
    }];
}


//给按钮添加图片
- (void)ButtonAddWithImagView:(NSString *)url{

    UIImageView *btnIamgeView = [[UIImageView alloc] init];
    
    btnIamgeView.image = [UIImage imageNamed:url];
    
    [self addSubview:btnIamgeView];
    
    [btnIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.centerY.equalTo(self.mas_centerY).offset(5);
        make.height.equalTo(@14);
        make.width.equalTo(@7);
    }];
    
}

/*
 *  给button 订制圆圈  颜色 主题色 宽 3
 */
- (void)ButtonAddCirce{

    UIImageView *btnImageView = [[UIImageView alloc] init];
    
    [self addSubview:btnImageView];
    
    btnImageView.backgroundColor = [UIColor whiteColor];
    
    btnImageView.layer.cornerRadius = (self.zf_width-6);
    
    btnImageView.layer.masksToBounds = YES;
    
    btnImageView.layer.borderWidth = 3;
    
    btnImageView.layer.backgroundColor = themeColor.CGColor;
    //适配
    btnImageView.frame = CGRectMake(self.zf_left+3,self.zf_top+3,self.zf_width-6,self.zf_height-3);
}

/*
 *  定制imageView
 */
- (void)ButtonAddImageViewActivityUI:(NSString *)url{
    
    UIImageView *btnImageView = [[UIImageView alloc] init];
    
    btnImageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-15-14,self.bounds.size.height/2-7,14,14);
    btnImageView.image = [UIImage imageNamed:@"found_Right"];
    
    [self addSubview:btnImageView];
    
   
}

@end
