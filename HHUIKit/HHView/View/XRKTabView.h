//
//  XRKTabView.h
//  YueDu
//
//  Created by liang on 15/2/3.
//  Copyright (c) 2015年 . All rights reserved.
//
//  

#import <UIKit/UIKit.h>

#define XRKTAB_BAR_HEIGHT 66   // 高度
#define XRKTAB_LINE_HEIGHT 2   //
//底部选择线长
#define XRKTAB_BUTTOM_LINE_WIDTH 80
//按钮空隙
#define XRKTAB_BUTTON_GAP 0
//按钮长度
//#define XRKTAB_BUTTON_WIDTH ((self.bounds.size.width/self.categories.count)>75.0?(self.bounds.size.width/self.categories.count):75.0)
#define XRKTAB_BUTTON_WIDTH (self.bounds.size.width/MIN(5, self.categories.count))
//按钮高度
#define XRKTAB_BUTTON_HEIGHT 66
//字体大小
#define XRKTAB_FONT_SIZE 14


@protocol XRKTabViewDelegate;

@interface XRKTabView : UIScrollView
{
    
}

- (XRKTabView *)initWithFrame:(CGRect) rect categories:(NSArray *) arrCategories withIndex:(NSInteger)currentIndex;
- (void)moveTagByRatio:(float) fRatio;
- (void)switchToPage:(int) nPageIndex;

@property (nonatomic, strong) NSArray *categories; // 分类数组
@property (nonatomic, strong) NSArray *cateNums; // 标题上的数字
@property (nonatomic, weak) id<XRKTabViewDelegate> tabDelegate;

@end

@protocol XRKTabViewDelegate<NSObject>

-(void)tabView:(XRKTabView *)tabView didSwitchToPage:(int) nPage;

@end
