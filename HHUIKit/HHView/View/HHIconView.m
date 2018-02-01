//
//  HHIconView.m
//  FunnyTicket
//
//  Created by 戴熙华 on 16/11/23.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "HHIconView.h"
#import <UIImageView+WebCache.h>
#import "UIView+Frame.h"

@interface HHIconView ()

@property(nonatomic, strong) UIImageView *iconView;

@property(nonatomic, strong) UIImageView *statusView;

@end

@implementation HHIconView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
        self.image = nil;
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)setUI{
    [self addSubview:self.iconView];
    [self addSubview:self.statusView];
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = NO;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _iconView.frame = self.bounds;
    _iconView.layer.cornerRadius = self.zf_height * .5;
    
    //CGSize size = _statusView.image.size;
    //_statusView.frame = CGRectMake(self.zf_width - size.width, self.zf_height - size.height, size.width, size.height);
    //_statusView.layer.cornerRadius = _statusView.zf_height * .5;
}

- (void)setImage:(UIImage *)image {
    _iconView.image = image;
}

- (void)setSex:(NSInteger)sex {
    
    _sex = sex;
    
    switch (sex) {
        case 0:
            
            self.statusView.image = nil;
            break;
        case 1:
            
            self.statusView.image = [UIImage imageNamed:@"icon_boy"];//icon_girl
            break;
            
        case 2:
            
            self.statusView.image = [UIImage imageNamed:@"icon_girl"];
            
        default:
            break;
    }
}

-(UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
       // _iconView.image = HeadPlaceholderImage;
         _iconView.image = [UIImage imageNamed:@""];
        _iconView.layer.masksToBounds = YES;
    }
    return _iconView;
}

-(UIImageView *)statusView{
    if (!_statusView) {
        _statusView = [[UIImageView alloc]init];
        _statusView.layer.masksToBounds = YES;
    }
    return _statusView;
}

@end
