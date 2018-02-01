//
//  HHRapBattleLikeBtn.h
//  FunnyTicket
//
//  Created by tasama on 17/8/17.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HHRapBattleLikeBtnType) {
    
    HHRapBattleLikeBtnTypeLeft = 0,
    HHRapBattleLikeBtnTypeRight = 1,
    HHRapBattleLikeBtnTypeBottom = 2
};

@interface HHRapBattleLikeBtn : UIButton

+ (instancetype)btnWithLikeNum:(NSInteger)num withBtnType:(HHRapBattleLikeBtnType)rapType;

+ (instancetype)btnWithCommentNum:(NSUInteger)num withBtnType:(HHRapBattleLikeBtnType)rapType;

@property (nonatomic, assign) HHRapBattleLikeBtnType btnType;

@end
