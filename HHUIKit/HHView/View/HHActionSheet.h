//
//  HHActionSheet.h
//  FunnyTicket
//
//  Created by XiaoZefeng on 14/10/16.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHActionSheet;

@protocol HHActionSheetDelegate <NSObject>

- (void)HHActionSheet:(HHActionSheet *_Nonnull)actionSheet clickedButtonAtIndex:(NSInteger )buttonIndex;

@end

@interface HHActionSheet : UIView

@property (nonatomic , weak)id <HHActionSheetDelegate> _Nullable delegate;
//_Nonnull _Nullable
- (instancetype _Nullable)initWithTitle:(NSString *_Nullable)title delegate:(id<HHActionSheetDelegate> _Nullable)delegate cancelButtonTitle:(NSString *_Nullable)cancelButtonTitle destructiveButtonTitle:(NSString *_Nullable)destructiveButtonTitle otherButtonTitles:(NSString *_Nullable)otherButtonTitles, ... ;

@property (nonatomic, strong) id object;

- (void)show;
- (void)hide;
- (void)addTitles:(NSArray *_Nullable)titles;
- (NSString * _Nullable)titleWithBtnIndex:(NSInteger)index;

@end
