//
//  HHVipHead.m
//  FunnyTicket
//
//  Created by tasama on 17/9/11.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHVipHead.h"
#import "UIImageView+HHQiniuThumbnail.h"

@interface HHVipHead ()

@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UIImageView *vipIcon;

@end

@implementation HHVipHead

+ (HHVipHead *)userIcon {
    
    HHVipHead *icon = [[NSBundle mainBundle] loadNibNamed:@"HHVipHead" owner:nil options:nil].lastObject;
    
    return icon;
}

- (void)setShowVipIcon:(BOOL)showVipIcon {
    
    _showVipIcon = showVipIcon;
    
    self.vipIcon.hidden = !showVipIcon;
}

- (void)hh_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)image {
    
    [self.headIcon hh_setImageWithURL:url placeholderImage:image];
}

- (void)setFrame:(CGRect)frame {
    
    [super setFrame:frame];
    
    self.headIcon.layer.cornerRadius = frame.size.width / 2.0f;
    self.headIcon.layer.masksToBounds = YES;
    self.headIcon.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headIcon.layer.borderWidth = 1.0f;
}

- (void)setBounds:(CGRect)bounds {
    
    [super setBounds:bounds];
    self.headIcon.layer.cornerRadius = bounds.size.width / 2.0f;
    self.headIcon.layer.masksToBounds = YES;
    self.headIcon.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headIcon.layer.borderWidth = 1.0f;
}

@end
