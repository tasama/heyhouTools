//
//  CenterBubble.h
//  CenterAnimation
//
//  Created by tasama on 17/8/15.
//  Copyright © 2017年 tasama. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, CenterBubblrPos) {
    
    CenterBubblrPosLeft = 0,
    CenterBubblrPosRight
};

@protocol CenterBubbleDelegate <NSObject>

- (void)didSelected:(BOOL)didSelected withPosition:(CenterBubblrPos)pos;

- (void)didTaped;

@end

@interface CenterBubble : UIView

@property (nonatomic, weak) id <CenterBubbleDelegate> delegate;

@end
