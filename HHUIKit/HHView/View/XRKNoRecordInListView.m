//
//  XRKNoRecordInListView.m
//  YueDu
//
//  Created by liang on 15/11/3.
//  Copyright © 2015年 . All rights reserved.
//

#import "XRKNoRecordInListView.h"
#import "UIView+Ext.h"
#import "NSString+XRKUtils.h"

@interface XRKNoRecordInListView ()

@property (weak, nonatomic) IBOutlet UIImageView *imgViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnNextAction;
@property (readwrite, nonatomic) SEL action;
@property (readwrite, nonatomic, weak) id target;

@end

@implementation XRKNoRecordInListView

+ (XRKNoRecordInListView *)createView
{
    NSString *sClassName = [NSString stringWithUTF8String:object_getClassName(self)];
    Class class = NSClassFromString(sClassName);
    
    return [class loadFromNib];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)setTitle:(NSString *)title
{
    self.labelTitle.text = title;
}

- (void)setIconWithName:(NSString *)iconName
{
    self.imgViewIcon.image = [UIImage imageNamed:iconName];
}

- (void)setBtnAction:(SEL)action atTarget:(id)target
{
    self.action = action;
    self.target = target;
}

- (void)setTarget:(id)target withTitle:(NSString *)title icon:(NSString *)iconName buttonTitle:(NSString *)btnTitle btnAction:(SEL)action
{
    self.imgViewIcon.image = [UIImage imageNamed:iconName];
    self.labelTitle.text = title;
    [self.btnNextAction setTitle:btnTitle forState:UIControlStateNormal];
    self.action = action;
    self.target = target;
    
    if (!btnTitle) {
        self.btnNextAction.hidden = YES;
    }
}

- (void)showInVC:(id)target withTitle:(NSString *)title icon:(NSString *)iconName buttonTitle:(NSString *)btnTitle btnAction:(SEL)action;
{
    self.imgViewIcon.image = [UIImage imageNamed:iconName];
    self.labelTitle.text = title;
    [self.btnNextAction setTitle:btnTitle forState:UIControlStateNormal];
    self.action = action;
    self.target = target;
    
    if (!btnTitle) {
        self.btnNextAction.hidden = YES;
    }
    
    UIViewController *vc = (UIViewController *)target;
    [vc.view addSubview:self];
}

- (IBAction)nextAction:(id)sender {
    __strong id target = self.target;
    
    if (target && [target respondsToSelector:_action]) {
        
        [target performSelectorOnMainThread:_action withObject:self waitUntilDone:YES];
    }
}

- (void)setButtonTitle:(NSString *)title
{
    [self.btnNextAction setTitle:title forState:UIControlStateNormal];
}


@end
