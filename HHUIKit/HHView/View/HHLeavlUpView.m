//
//  HHLeavlUpView.m
//  FunnyTicket
//
//  Created by tasama on 16/11/22.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import "HHLeavlUpView.h"
#import "UIColor+Hex.h"
#import "HHUIConst.h"
#import <UIImageView+WebCache.h>


@interface HHLeavlUpView ()

@property (nonatomic, strong) UIImageView *backLight;

@property (nonatomic, strong) UIImageView *badge;

@property (nonatomic, assign) double angle;


@end

@implementation HHLeavlUpView

+ (instancetype)buildWithLeavlId:(NSInteger)leavlId andNickName:(NSString *)nickName andIconImage:(NSString *)icon {
    
    HHLeavlUpView *leavlView = [[self alloc]init];
    
    leavlView.leavlId = leavlId;
    leavlView.nickName = nickName;
    leavlView.iconImage = icon;
    
    return leavlView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

#define backGroundWidth 230 * SCREEN_WIDTH / 375.0
#define backGroundHeight 40 * SCREEN_HEIGHT / 667.0
//定义UIImage对象
#define ImageNamed(A) [UIImage imageNamed:A]
//placeholderimage
#define PlaceholderImage ImageNamed(@"placeHolderForFs") //常用默认背景图
#define ThemeTextColor [UIColor colorWithHexString:@"ffffff" alpha:.5]
#define ThemeTextColorLight [UIColor colorWithHexString:@"ffffff" alpha:0.8]
//弱引用/强引用
#define kWeakSelf(type) __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;
#define MidTextFont [UIFont systemFontOfSize:12]

- (void)startShowUser {
    
    UIView *backGroundView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT / 2.0 + SCREEN_WIDTH / 4.0, backGroundWidth, backGroundHeight)];
    backGroundView.layer.cornerRadius = backGroundHeight / 2.0;
    backGroundView.layer.masksToBounds = YES;
    backGroundView.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:.4f];
    
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, backGroundHeight, backGroundHeight)];
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:self.iconImage] placeholderImage:PlaceholderImage];
    iconImageView.layer.cornerRadius = backGroundHeight / 2.0;
    iconImageView.layer.masksToBounds = YES;
    iconImageView.backgroundColor = ThemeTextColor;
    
    NSString *leavlString;
    switch (self.leavlId) {
        case 0:
            leavlString = @"嘻哈青铜骑士";
            break;
        case 1:
            leavlString = @"嘻哈白银骑士";
            break;
        case 2:
            leavlString = @"嘻哈黄金骑士";
            break;
        case 3:
            leavlString = @"嘻哈钻石骑士";
            break;
        case 4:
            leavlString = @"嘻哈勋爵";
            break;
        case 5:
            leavlString = @"嘻哈男爵";
            break;
        case 6:
            leavlString = @"嘻哈子爵";
            break;
        case 7:
            leavlString = @"嘻哈伯爵";
            break;
        case 8:
            leavlString = @"嘻哈侯爵";
            break;
        case 9:
            leavlString = @"嘻哈公爵";
            break;
        case 10:
            leavlString = @"嘻哈亲王";
            break;
        case 11:
            leavlString = @"嘻哈大帝";
            break;

            
        default:
            break;
    }
    
    NSString *string;
    if (self.type) {
        
        string = [NSString stringWithFormat:@"欢迎“%@“%@进入直播间~", leavlString, self.nickName];
    } else {
        
        string = [NSString stringWithFormat:@"祝贺“%@”荣升为“%@”",self.nickName, leavlString];
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string];
    
    NSDictionary *subStrAttribute1 = @{
                                       NSForegroundColorAttributeName: ThemeTextColorLight,
                                       NSFontAttributeName : MidTextFont
                                       };
    NSDictionary *subStrAttribute2 = @{
                                       NSForegroundColorAttributeName: [UIColor colorWithHexString:@"fff000"],
                                       NSFontAttributeName: MidTextFont
                                       };
    if (self.type) {
        
        [attributedString setAttributes:subStrAttribute1 range:NSMakeRange(0, 2)];
        [attributedString setAttributes:subStrAttribute2 range:NSMakeRange(2, leavlString.length + 2 + self.nickName.length)];
        [attributedString setAttributes:subStrAttribute1 range:NSMakeRange(leavlString.length + 2 + self.nickName.length + 2, 6)];
    } else {
        
        [attributedString setAttributes:subStrAttribute1 range:NSMakeRange(0, 2)];
        [attributedString setAttributes:subStrAttribute2 range:NSMakeRange(2, self.nickName.length + 2)];
        [attributedString setAttributes:subStrAttribute1 range:NSMakeRange(2 + self.nickName.length + 2, 3)];
        [attributedString setAttributes:subStrAttribute2 range:NSMakeRange(2 + self.nickName.length + 2 + 3, leavlString.length + 2)];
    }
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(2 + backGroundHeight, 0, backGroundWidth - backGroundHeight * 1.5, backGroundHeight)];
    titleLabel.numberOfLines = 2;
    titleLabel.attributedText = attributedString;
    
    [self addSubview:backGroundView];
    [backGroundView addSubview:iconImageView];
    [backGroundView addSubview:titleLabel];
    
    kWeakSelf(self);
    [UIView animateWithDuration:5.0f animations:^{
        
        backGroundView.frame = CGRectMake(- backGroundWidth, SCREEN_HEIGHT / 2.0 + SCREEN_WIDTH / 4.0, backGroundWidth, backGroundHeight);
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            [backGroundView removeFromSuperview];
            [weakself startShowUser];
        }
    }];
}

- (void)setupUI {
    
    self.angle = 0.0;
    //添加控件
    [self addSubview:self.backLight];
    [self addSubview:self.badge];

    [self startAnimation];
}

- (void)startAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    self.backLight.transform = CGAffineTransformMakeRotation(self.angle * (M_PI / 180.0f));
    [UIView commitAnimations];
}

-(void)endAnimation
{
    self.angle += 10;
    
    [self startAnimation];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //填写布局约束
    self.backLight.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH);
    self.badge.bounds = CGRectMake(0, 0, SCREEN_WIDTH / 2.0, SCREEN_WIDTH / 2.0);
    
    self.backLight.center = CGPointMake(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT / 2.0);
    self.badge.center = CGPointMake(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT / 2.0);
    
}

- (void)showInView:(UIView *)view {
    
    self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    [view addSubview:self];
    [self startShowUser];
    [UIView animateWithDuration:.25f animations:^{
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

- (void)show {
    
    self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self startShowUser];
    [UIView animateWithDuration:.25f animations:^{
       
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

- (void)hiden {
    
    if (self.superview) {
        
        [UIView animateWithDuration:.25f animations:^{
            
            self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self hiden];
}

- (void)setLeavlId:(NSInteger)leavlId {
    
    _leavlId = leavlId;
    
    NSString *imageName = [NSString stringWithFormat:@"live_huizhang_%zd",leavlId];
    self.badge.image = [UIImage imageNamed:imageName];
}

#pragma mark - 懒加载
- (UIImageView *)backLight
{
    if (!_backLight) {
        _backLight = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"live_huizhang_texiaodi"]];
    }
    
    return _backLight;
}

- (UIImageView *)badge
{
    if (!_badge) {
        _badge = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"live_huizhang_baiyin"]];
    }
    
    return _badge;
}


@end
