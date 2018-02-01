//
//  HHAppUpdateViewController.m
//  FunnyTicket
//
//  Created by tasama on 17/5/31.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHAppUpdateViewController.h"
#import "HHUpdateForceButton.h"
#import "UIColor+Hex.h"
#import "HHRouterManager.h"
#import "UIView+Frame.h"
#import "HHUIConst.h"

@interface HHAppUpdateViewController ()

@property (nonatomic, copy) NSString *detailString;

@property (nonatomic, copy) NSString *updateUrl;

@property (nonatomic, strong) UIImageView *backGroundView;

@property (nonatomic, strong) UIImageView *logoView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) HHUpdateForceButton *updateBtn;

@end

@implementation HHAppUpdateViewController

- (void)setParameters:(NSMutableDictionary *)parameters {
    
    [super setParameters:parameters];
    
    if ([parameters valueForKey:@"detail"]) {
        
        NSString *detailString = [parameters valueForKey:@"detail"];
        
        self.detailString = detailString;
        
        self.detailLabel.text = self.detailString;
    }
    
    if ([parameters valueForKey:@"url"]) {
        
        NSString *updateUrl = [parameters valueForKey:@"url"];
        
        self.updateUrl = updateUrl;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithHexString:@"181818"];
    
    [self setupUI];
}

- (void)appDidActivited {
    
    
}

- (void)setupUI {
    
    [self.view addSubview:self.backGroundView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.detailLabel];
    [self.view addSubview:self.logoView];
    [self.view addSubview:self.updateBtn];
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    self.backGroundView.frame = CGRectMake(42.5 * ScreenWidthScale, 121.5 * ScreenHeightScale, SCREEN_WIDTH - 2 * 42.5 * ScreenWidthScale, SCREEN_HEIGHT - 2 * 121.5 * ScreenHeightScale);
    
    self.titleLabel.frame = CGRectMake(self.backGroundView.zf_left, self.backGroundView.zf_top + 24.0f, self.backGroundView.zf_width, 38.0f);
    self.detailLabel.frame = CGRectMake(self.titleLabel.zf_left, self.titleLabel.zf_bottom + 12.0f, self.titleLabel.zf_width, 40.0f);
    self.logoView.frame = CGRectMake(self.backGroundView.zf_left + 15.0f, self.detailLabel.zf_bottom + 20.0f, self.backGroundView.zf_width - 30.0f, self.backGroundView.zf_width - 30.0f);
    self.updateBtn.frame = CGRectMake(self.backGroundView.zf_left + 40 * ScreenWidthScale, self.backGroundView.zf_bottom - 22.0f, self.backGroundView.zf_width - 80 * ScreenWidthScale, 44.0f);
}

#pragma mark - action
- (void)update {
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:HH_APP_DOWNLOAD_ADDRESS]]) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:HH_APP_DOWNLOAD_ADDRESS]];
    }
}

#pragma mark - get
- (UIImageView *)backGroundView
{
    if (!_backGroundView) {
        _backGroundView = [[UIImageView alloc]init];
        _backGroundView.image = [UIImage imageNamed:@"UpdateForceBg"];
    }
    
    return _backGroundView;
}

- (UIImageView *)logoView
{
    if (!_logoView) {
        _logoView = [[UIImageView alloc]init];
        _logoView.image = [UIImage imageNamed:@"UpdateForceLogo"];
    }
    
    return _logoView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"嘿吼升级啦";
        _titleLabel.font = [UIFont systemFontOfSize:36.0f weight:UIFontWeightMedium];
        _titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.text = @"全新的界面，更好玩的功能，\n老铁快来感受下";
        _detailLabel.font = [UIFont systemFontOfSize:15.0f weight:UIFontWeightMedium];
        _detailLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.numberOfLines = 2;
    }
    
    return _detailLabel;
}

- (HHUpdateForceButton *)updateBtn
{
    if (!_updateBtn) {
        _updateBtn = [[HHUpdateForceButton alloc]init];
        _updateBtn.btnLabel.text = @"立即体验";
        _updateBtn.btnLabel.textColor = HH_COLOR_RED;
        _updateBtn.btnLabel.font = [UIFont systemFontOfSize:17.0f weight:UIFontWeightMedium];
        [_updateBtn addTarget:self WithAction:@selector(update)];
        _updateBtn.layer.cornerRadius = 22.0f;
    }
    
    return _updateBtn;
}

@end
