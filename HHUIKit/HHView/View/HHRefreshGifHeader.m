//
//  HHRefreshGifHeader.m
//  MJRefreshTest
//
//  Created by tasama on 17/4/25.
//  Copyright © 2017年 tasama. All rights reserved.
//

#import "HHRefreshGifHeader.h"
#import "UIColor+setGradualChangingColor.h"
#import "UIColor+Hex.h"
#import "HHUIConst.h"

@implementation HHRefreshGifHeader

- (void)prepare {
    
    [super prepare];
    
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"释放加载" forState:MJRefreshStatePulling];
    [self setTitle:@"加载中" forState:MJRefreshStateRefreshing];
    [self setTitle:@"加载中" forState:MJRefreshStateWillRefresh];
    [self setTitle:@"所有数据加载完毕，没有更多的数据了" forState:MJRefreshStateNoMoreData];
    
    self.stateLabel.font = [UIFont systemFontOfSize:13.0f];
    self.stateLabel.textColor = [UIColor colorWithHexString:@"666666"];
    self.stateLabel.textAlignment = NSTextAlignmentLeft;
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    self.automaticallyChangeAlpha = YES;
    self.gifView.contentMode = UIViewContentModeScaleAspectFit;
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int i = 0; i < 12; i++) {
        
        UIImage *image;
        
        image = [UIImage imageNamed:[NSString stringWithFormat:@"danceMan%d", i]];

        [idleImages addObject:image];
    }
    
    [self setImages:@[[UIImage imageNamed:@"danceMan0"]] forState:MJRefreshStateIdle];
    
    [self setImages:@[[UIImage imageNamed:@"danceMan0"]] forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:idleImages forState:MJRefreshStateRefreshing];
}

- (void)placeSubviews {
    
    [super placeSubviews];
    
    UIImage *image = [UIImage imageNamed:@"danceMan0"];
    CGFloat width = image.size.width / image.scale;
    CGFloat height = image.size.height / image.scale;
    
    self.mj_h = height + 20.0f;
    self.gifView.frame = CGRectMake((SCREEN_WIDTH - width) / 2.0f, 0, width, height);
//    self.stateLabel.frame = CGRectMake(self.gifView.zf_right, (height - 17.0f) / 2.0f, labelWidth, 17.0f);
}

- (void)endRefreshing {
    
    [super endRefreshing];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
}

@end
