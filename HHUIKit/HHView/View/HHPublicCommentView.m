//
//  HHPublicCommentView.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 8/5/17.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHPublicCommentView.h"
#import "UIView+Frame.h"
#import "UIColor+Hex.h"
#import "HHUIConst.h"
#import "HHAlert.h"
#import "UIButton+Create.h"

@interface HHPublicCommentView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *sendButton;

@property (nonatomic, strong) UITextField *textField;

@end

#define PUBLICCOMMENTMAX 140 //最大输入字符

@implementation HHPublicCommentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _maxInputCount = PUBLICCOMMENTMAX;
        _placeholdeString = @"表达你的态度";
        [self setupSubviews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews {
    
    CGFloat subviewHeight = 35;
    CGFloat top = self.zf_height > subviewHeight ? (self.zf_height - subviewHeight) * .5 : 0;
    
    _sendButton.frame = CGRectMake(self.zf_width - 70 - LEFT_INSET, top, 70, self.zf_height - 2 * top);
    
    _textField.frame = CGRectMake(LEFT_INSET, top, _sendButton.zf_left - LEFT_INSET - 5, _sendButton.zf_height);
}

- (void)setupSubviews {
    [self addSubview:self.textField];
    [self addSubview:self.sendButton];
    self.layer.borderWidth = .5;
    self.layer.borderColor = HH_COLOR_LINE.CGColor;
}

- (void)setPlaceholdeString:(NSString *)placeholdeString {
    _placeholdeString = placeholdeString;
    
    _textField.placeholder = placeholdeString;
}

- (void)commentViewResignFirstResponder {
    [_textField resignFirstResponder];
    _textField.placeholder = @"表达你的态度";
}

- (void)clearText {
    _textField.text = nil;
    _textField.placeholder = @"表达你的态度";
}

- (void)commentViewBecomeFirstResponder {
    [_textField becomeFirstResponder];
}

- (void)valueChange:(UITextField *)textfield {
    
    NSString *text = textfield.text;
    
    if (text.length > _maxInputCount) {
        text = [text substringToIndex:_maxInputCount];
    }
    textfield.text = text;
}

- (void)sendText:(NSString *)text {
    if (![text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length) {
        //不允许输入空格、回车
        [HHAlert showAlertString:[NSString stringWithFormat:@"最多只能评论%zd个字",_maxInputCount]];
        return;
    }
    if ([_delegate respondsToSelector:@selector(publicCommentViewSendMessage:)]) {
        [_delegate publicCommentViewSendMessage:text];
    }
}

- (void)clickSend:(UIButton *)btn {
    [_textField resignFirstResponder];
    
    [self sendText:_textField.text];
}

- (UIButton *)sendButton {
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithFont:[UIFont systemFontOfSize:15.f] textColor:[UIColor whiteColor] title:@"发送" target:self event:@selector(clickSend:)];
        _sendButton.layer.cornerRadius = 5;
        _sendButton.layer.masksToBounds = YES;
        _sendButton.backgroundColor = HH_COLOR_RED;
    }
    return _sendButton;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self sendText:_textField.text];
    return YES;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.textColor = HH_COLOR_TEXT_MAIN_BLACK;
        _textField.font = [UIFont systemFontOfSize:12.f];
        [_textField setValue:HH_COLOR_TEXT_SUB forKeyPath:@"_placeholderLabel.textColor"];
        _textField.placeholder = _placeholdeString;
        _textField.backgroundColor = HH_COLOR_F0_GRAY;
        _textField.layer.cornerRadius = 5;
        [_textField addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
        UIView *view = [UIView new];
        view.frame = CGRectMake(0, 0, LEFT_INSET, 1);
        _textField.leftView = view;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.rightView = view;
        _textField.rightViewMode = UITextFieldViewModeAlways;
        _textField.returnKeyType = UIReturnKeySend;
        _textField.delegate = self;
    }
    return _textField;
}

@end
