//
//  XRKTabView.m
//  YueDu
//
//  Created by liang on 15/2/3.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "XRKTabView.h"
#import "UIColor+Hex.h"
#import "UIView+Frame.h"
#import "HHUIConst.h"

// 16进制颜色转UIColor
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:((c)&0xFF)/255.0 alpha:1.0]
// 16进制颜色转UIColor并加透明
#define HEXCOLORWITHALPHA(c,a) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:((c)&0xFF)/255.0 alpha:a]


@interface XRKTabView()

@property (nonatomic, strong) UILabel *labelLine;
@property (nonatomic, assign) int nCurrentSelect;
@property (nonatomic, strong) NSMutableArray *arrNumLabels;

@end

@implementation XRKTabView

- (XRKTabView *)initWithFrame:(CGRect) rect categories:(NSArray *) arrCategories withIndex:(NSInteger)currentIndex
{
    self = [super initWithFrame:rect];
    
    self.arrNumLabels = [[NSMutableArray alloc] init];
    
    if (self) {
        self.bounces = NO;
        self.scrollsToTop = NO;
        self.backgroundColor  = HH_COLOR_THEME_BACKGROUND;
        self.nCurrentSelect = currentIndex;
        
        self.categories = arrCategories;
        NSUInteger nBtnCount = self.categories.count;
        
//         NSLog(@"%f,%f,%f,%f", self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        NSLog(@"XRKTAB_BUTTON_WIDTH  %f,", XRKTAB_BUTTON_WIDTH);
        
        self.showsHorizontalScrollIndicator = NO;
        self.contentOffset = CGPointMake(0, 0);
        self.contentSize = CGSizeMake(XRKTAB_BUTTON_WIDTH * nBtnCount, self.frame.size.height);
        
        UILabel *labelBgLine = [[UILabel alloc] initWithFrame:CGRectMake(0, XRKTAB_BAR_HEIGHT-0.5, self.frame.size.width * nBtnCount, 0.5)];
        labelBgLine.backgroundColor = HH_COLOR_LINE;//HEXCOLOR(0xffffff);
        [self addSubview:labelBgLine];

        
        for (int i = 0; i < [arrCategories count]; i++) {
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(XRKTAB_BUTTON_GAP+(XRKTAB_BUTTON_GAP+XRKTAB_BUTTON_WIDTH)*i, XRKTAB_LINE_HEIGHT, XRKTAB_BUTTON_WIDTH, XRKTAB_BUTTON_HEIGHT)];
            [self addSubview:view];
            
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
//            label.textColor = HEXCOLOR(0xf33f40);
            label.textAlignment = NSTextAlignmentCenter;
            label.frame = CGRectMake(0, 15, view.zf_width, 20);
            //label.text = @"200";
            label.tag = 1000;
            [view addSubview:label];
            [self.arrNumLabels addObject:label];
            
            UILabel *label2 = [[UILabel alloc] init];
            label2.font = [UIFont systemFontOfSize:12];
//            label2.font = [UIFont systemFontOfSize:12];
//            label2.textColor = HEXCOLOR(0xf33f40);
            label2.textAlignment = NSTextAlignmentCenter;
            label2.frame = CGRectMake(0, label.zf_bottom + 7, view.zf_width, 12);
            label2.text = [arrCategories objectAtIndex:i];
            label2.tag = 1001;
            [view addSubview:label2];
            
            if (i == 0)
            {
                label.textColor = HEXCOLOR(0xf33f40);
                label2.textColor = HEXCOLOR(0xf33f40);
            }
            else
            {
                label.textColor = HH_COLOR_99_GRAY;
                label2.textColor = HH_COLOR_99_GRAY;
            }
            
            view.tag = 100 + i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewItem:)];
            [view addGestureRecognizer:tap];
            
            
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            [button setFrame:CGRectMake(XRKTAB_BUTTON_GAP+(XRKTAB_BUTTON_GAP+XRKTAB_BUTTON_WIDTH)*i, XRKTAB_LINE_HEIGHT, XRKTAB_BUTTON_WIDTH, XRKTAB_BUTTON_HEIGHT)];
//            [button setTag:100+i];
//            if (i == currentIndex) {
//                button.selected = YES;
//            }
//            [button setTitle:[NSString stringWithFormat:@"%@",[arrCategories objectAtIndex:i]] forState:UIControlStateNormal];
//            button.titleLabel.font = [UIFont systemFontOfSize:XRKTAB_FONT_SIZE];
//            [button setTitleColor:HEXCOLORWITHALPHA(0xffffff, 0.5) forState:UIControlStateNormal];
//            [button setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateSelected];
//            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//            [self addSubview:button];
        }
//        _labelLine = [[UILabel alloc] initWithFrame:CGRectMake(currentIndex * XRKTAB_BUTTON_WIDTH + (XRKTAB_BUTTON_WIDTH - XRKTAB_BUTTOM_LINE_WIDTH) / 2, XRKTAB_BAR_HEIGHT-XRKTAB_LINE_HEIGHT, XRKTAB_BUTTOM_LINE_WIDTH, XRKTAB_LINE_HEIGHT)];
        _labelLine = [[UILabel alloc] initWithFrame:CGRectMake(currentIndex * XRKTAB_BUTTON_WIDTH + 10, XRKTAB_BAR_HEIGHT-XRKTAB_LINE_HEIGHT, XRKTAB_BUTTON_WIDTH - 20, XRKTAB_LINE_HEIGHT)];
        _labelLine.backgroundColor = HEXCOLOR(0xf33f40);
        [self addSubview:_labelLine];
    }
    
    return self;
}

-(void)tapViewItem:(UITapGestureRecognizer *)tap
{
    UIView *view = tap.view;
    int nPage = view.tag - 100;
    [self switchToPage:nPage];
    
    if (self.tabDelegate && [self.tabDelegate respondsToSelector:@selector(tabView:didSwitchToPage:)])
    {
        [self.tabDelegate tabView:self didSwitchToPage:nPage];
    }
}

- (void)setCateNums:(NSArray *)cateNums
{
    _cateNums = cateNums;
    
    if (_cateNums.count != _categories.count) {
        return;
    }
    
    for (int i = 0; i < _arrNumLabels.count; i++) {
        UILabel *label = [_arrNumLabels objectAtIndex:i];
        label.text = [[_cateNums objectAtIndex:i] stringValue];
    }
}

//-(void)btnClick:(id)sender
//{
//    UIButton * btn = (UIButton *)sender;
//    int nPage = btn.tag - 100;
//    [self switchToPage:nPage];
//    
//    if (self.tabDelegate && [self.tabDelegate respondsToSelector:@selector(tabView:didSwitchToPage:)])
//    {
//        [self.tabDelegate tabView:self didSwitchToPage:nPage];
//    }
//}

- (NSArray *)categories
{
    if (!_categories) {
        _categories = [[NSArray alloc] init];
    }
    
    return _categories;
}

- (void)moveTagByRatio:(float) fRatio
{
//    self.labelLine.frame =  CGRectMake(fRatio * self.contentSize.width, self.labelLine.frame.origin.y, self.labelLine.frame.size.width, self.labelLine.frame.size.height);
    
    float fNewOffset = MIN(fRatio * self.contentSize.width * (self.contentSize.width - self.frame.size.width) / self.frame.size.width, self.contentSize.width - self.frame.size.width);
    
    self.contentOffset = CGPointMake(fNewOffset, 0);
    
}

- (void)moveTagByOffset:(float) fOffset
{
    self.labelLine.frame =  CGRectMake(fOffset, self.labelLine.frame.origin.y, self.labelLine.frame.size.width, self.labelLine.frame.size.height);
    
    float fNewOffset = MIN(fOffset * (self.contentSize.width - self.frame.size.width) / self.frame.size.width, self.contentSize.width - self.frame.size.width);
    //float fNewOffset = fOffset;
    self.contentOffset = CGPointMake(fNewOffset, 0);
    
}

- (void)switchToPage:(int) nPageIndex
{
    UIView *btnOldSelect = (UIButton *)[self viewWithTag:(100+self.nCurrentSelect)];
    UILabel *label1 = (UILabel *)[btnOldSelect viewWithTag:1000];
    UILabel *label2 = (UILabel *)[btnOldSelect viewWithTag:1001];
    label1.textColor = HH_COLOR_99_GRAY;
    label2.textColor = HH_COLOR_99_GRAY;
//    btnOldSelect.selected = NO;

    self.nCurrentSelect = nPageIndex;
    UIView *btnNowSelect = (UIButton *)[self viewWithTag:(100+self.nCurrentSelect)];
    UILabel *newlabel1 = (UILabel *)[btnNowSelect viewWithTag:1000];
    UILabel *newlabel2 = (UILabel *)[btnNowSelect viewWithTag:1001];
    newlabel1.textColor = HEXCOLOR(0xf33f40);
    newlabel2.textColor = HEXCOLOR(0xf33f40);
//    btnNowSelect.selected = YES;
    [self moveTagByOffset:nPageIndex * XRKTAB_BUTTON_WIDTH + 10];
}

@end
