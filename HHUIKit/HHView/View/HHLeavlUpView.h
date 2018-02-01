//
//  HHLeavlUpView.h
//  FunnyTicket
//
//  Created by tasama on 16/11/22.
//  Copyright © 2016年 HH_Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    kLevelUpTypeUp,
    kLevelUpTypeIn
    
}leavlUpType;

@interface HHLeavlUpView : UIView

@property (nonatomic, assign) NSInteger leavlId;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *iconImage;

@property (nonatomic, assign) leavlUpType *type;


+ (instancetype)buildWithLeavlId:(NSInteger)leavlId andNickName:(NSString *)nickName andIconImage:(NSString *)icon;

- (void)showInView:(UIView *)view;

- (void)show;

- (void)hiden;

@end
