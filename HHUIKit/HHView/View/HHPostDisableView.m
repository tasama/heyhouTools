//
//  HHPostDisableView.m
//  FunnyTicket
//
//  Created by tasama on 17/4/7.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import "HHPostDisableView.h"
#import "UIColor+Hex.h"
#import "HHUIConst.h"

@interface HHPostDisableView ()

@property (weak, nonatomic) IBOutlet UILabel *tipMessage;

@property (weak, nonatomic) IBOutlet UIView *navView;

@end

@implementation HHPostDisableView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.backgroundColor = HH_COLOR_THEME_BACKGROUND;
    self.navView.backgroundColor = [UIColor colorWithHexString:@"181818"];
}

- (IBAction)backAction {
    
    if (self.backBlock) {
        
        self.backBlock();
    }
}

- (void)setTipMessageString:(NSString *)tipMessageString {
    
    _tipMessageString = tipMessageString;
    
    self.tipMessage.text = tipMessageString;
}


@end
