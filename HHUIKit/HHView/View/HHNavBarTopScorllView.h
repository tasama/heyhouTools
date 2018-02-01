//
//  HHNavBarTopScorllView.h
//  FunnyTicket
//
//  Created by tasama on 16/10/27.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHNavBarTopScorllView : UIView

//标题
@property (nonatomic , strong)NSArray *titles;
//当前下标
@property (nonatomic , assign)NSInteger currentIndex;

@property (nonatomic , strong)UILabel *line;

@property (nonatomic , copy)void (^clickedButtonAtIndex)(NSInteger buttonIndex);

- (instancetype)initWithTitles:(NSArray *)titles;

@end
