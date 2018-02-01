//
//  SwaggerWindowView.m
//  FunnyTicket
//
//  Created by tasama on 17/8/8.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "SwaggerWindowView.h"
#import "UIImageView+HHQiniuThumbnail.h"

@interface SwaggerWindowView ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@end

@implementation SwaggerWindowView

+ (instancetype)loadView {
    
    return [[NSBundle mainBundle] loadNibNamed:@"SwaggerWindowView" owner:nil options:nil].lastObject;
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    
    [super willMoveToWindow:newWindow];
    
    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.coverImageView.clipsToBounds = YES;
    NSString *picKey = @"picUrl";
    UIImage *picUrl = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] valueForKey:picKey]];
    self.coverImageView.image = picUrl;
}

- (void)setCoverUrl:(NSString *)coverUrl {
    
    _coverUrl = coverUrl;
    
    [self.coverImageView hh_setImageWithURL:[NSURL URLWithString:coverUrl]];
}

- (IBAction)joinAction:(UIButton *)sender {
    
    if ([self.myDelegate respondsToSelector:@selector(didClickedBtnAction:)]) {
        
        [self.myDelegate didClickedBtnAction:self];
    }
}

- (IBAction)closeAdViewAction:(UIButton *)sender {
    
    if ([self.myDelegate respondsToSelector:@selector(didClickCloseBtnAction:)]) {
        
        [self.myDelegate didClickCloseBtnAction:self];
    }
}

@end
