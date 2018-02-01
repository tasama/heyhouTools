//
//  HHNormalInputCell.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 14/4/17.
//  Copyright © 2017年 HH_Xiao. All rights reserved.
//

#import "HHNormalInputCell.h"
#import "UIView+Frame.h"
#import "HHUIConst.h"
#import "UIColor+Hex.h"

@interface HHNormalInputCell ()<UITextFieldDelegate>

@end

@implementation HHNormalInputCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.textField];
        _maxCount = 30;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _textField.frame = CGRectMake(LEFT_INSET, self.zf_height * .5 - 15, self.zf_width - 2 * LEFT_INSET, 30);
}

- (void)textFieldChange:(UITextField *)textfield {
    if (textfield.text.length > _maxCount) {
        textfield.text = [textfield.text substringToIndex:_maxCount];
    }
    !_valueDidChange ? : _valueDidChange(textfield);
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:15.f];
        [_textField setValue:HH_COLOR_TEXT_SUB forKeyPath:@"_placeholderLabel.textColor"];
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_inputEndBlock) {
        _inputEndBlock (textField.text);
    }
}

@end
