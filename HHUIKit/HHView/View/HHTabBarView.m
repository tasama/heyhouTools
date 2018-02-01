//
//  HHTabBarView.m
//  FunnyTicket
//
//  Created by tasama on 17/7/13.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHTabBarView.h"
#import "UIColor+setGradualChangingColor.h"
#import "UIView+Frame.h"

@interface HHTabBarView ()

@property (nonatomic, strong) UIButton *midBtn;

@end

@implementation HHTabBarView

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self initTab];
        [self setMidBtn];
    }
    return self;
}

- (void)initTab {
    
    NSArray *tabbarImages =  @[@"home_nor",
                               @"show_nor",
                               @"tab",
                               @"discover_nor",
                               @"me_nor"];
    
    NSArray *tabbarSelects = @[@"home-hl",
                               @"show_hl",
                               @"tab",
                               @"discover_hl",
                               @"me_hl"];
    
    NSArray *tabbarTitles = @[@"", @"", @"", @"", @""];//@[@"街区",@"潮拍",@"",@"发现",@"我的"];
    
    NSMutableArray *items = @[].mutableCopy;
    for (int i = 0; i < tabbarTitles.count; i++) {
        
        UITabBarItem *item = [[UITabBarItem alloc] init];
        item.title = tabbarTitles[i];
        item.image = [UIImage imageNamed:tabbarImages[i]];
        item.selectedImage = [UIImage imageNamed:tabbarSelects[i]];
        item.tag = i;
        [items addObject:item];
        item.imageInsets = UIEdgeInsetsMake(6, 0, - 6, 0);
    }
    self.items = items.copy;
    self.selectedItem = items[0];
    self.barStyle = UIBarStyleBlack;
    self.clipsToBounds = NO;
}

- (void)setMidBtn {
    
    UIButton *button = [[UIButton alloc]init];
    button.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [button setImage:[UIImage imageNamed:@"btn_music_nor"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"btn_music_pre"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(midBtnDidSelcted:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [self bringSubviewToFront:button];
    
    self.midBtn = button;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.midBtn setFrame:CGRectMake((self.zf_width - 54.0f) / 2.0f, - 11, 54.0f, 54.0f)];
}

- (void)midBtnDidSelcted:(UIButton *)midBtn {
    
    [self.delegate tabBar:self didSelectItem:self.items[2]];
}

@end
