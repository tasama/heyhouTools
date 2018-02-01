//
//  HHPageControl.m
//  FunnyTicket
//
//  Created by XiaoZefeng on 26/5/17.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import "HHPageControl.h"
#import "UIView+Frame.h"

@interface HHPageControl ()

@property (nonatomic, strong) NSMutableArray *circles;

@end

@implementation HHPageControl

+ (void)initialize {
    HHPageControl *pageControl = [self appearance];
    pageControl.itemSize = CGSizeMake(6, 6);
    pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.currentPage = 0;
    pageControl.space = 10;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _circles = [NSMutableArray array];
    }
    return self;
}

- (void)setCurrentPage:(NSInteger)currentPage {
    
    if (currentPage >= self.numberOfPages || currentPage >= _circles.count || _currentPage >= _circles.count) return;
    
    UIView *lastCircle = _circles[_currentPage];
    lastCircle.backgroundColor = self.pageIndicatorTintColor;
    
    _currentPage = currentPage;
    UIView *currentCircle = _circles[currentPage];
    currentCircle.backgroundColor = self.currentPageIndicatorTintColor;
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    _numberOfPages = numberOfPages;
    
    [_circles makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_circles removeAllObjects];
    
    for (int i = 0; i < numberOfPages; i++) {
        UIView *circle = [UIView new];
        circle.bounds = (CGRect){CGPointZero, self.itemSize};
        circle.backgroundColor = self.pageIndicatorTintColor;
        circle.layer.masksToBounds = YES;
        circle.layer.cornerRadius = circle.zf_height * .5;
        [_circles addObject:circle];
        [self addSubview:circle];
    }
    
    self.currentPage = 0;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat allLength = _circles.count * self.itemSize.width + (_circles.count - 1) * self.space;
    
    CGFloat originX = (self.zf_width - allLength) * .5;
    
    CGFloat originY = (self.zf_height - self.itemSize.height) * .5;
    
    for (int i = 0; i < _circles.count; i++) {
        UIView *circle = _circles[i];
        circle.zf_origin = CGPointMake(originX + i * (self.itemSize.width + self.space), originY);
    }
    
}

@end
