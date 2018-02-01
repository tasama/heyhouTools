//
//  HHRapLeaderView.m
//  FunnyTicket
//
//  Created by tasama on 17/9/15.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHRapLeaderView.h"
#import "HHGuideTool.h"
#import "HHUIConst.h"
#import "UIView+ViewController.h"

@interface HHRapLeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *leadPoint;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *midBtn;
@property (unsafe_unretained, nonatomic) IBOutlet NSLayoutConstraint *midBottomConstraint;

@end

@implementation HHRapLeaderView

+ (instancetype)shared {
    
    static HHRapLeaderView *view = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        view = [[NSBundle mainBundle] loadNibNamed:@"HHRapLeaderView" owner:nil options:nil].lastObject;
    });
    return view;
}

+ (void)show {
    
    if ([HHGuideTool firstShowRecordArrow]) {
        
        return;
    }
    HHRapLeaderView *view = [HHRapLeaderView shared];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    [super willMoveToSuperview:newSuperview];
    [self setNeedsLayout];
    if (@available(iOS 11, *)) {
        
        self.midBottomConstraint.constant = newSuperview.safeAreaInsets.bottom;
    } else {
        
        self.midBottomConstraint.constant = 0.0f;
    }
    [self layoutIfNeeded];
    
}


- (IBAction)midBtnClicked:(UIButton *)sender {
    
    [self hide];
}

- (void)hide {
    
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self hide];
}

@end
