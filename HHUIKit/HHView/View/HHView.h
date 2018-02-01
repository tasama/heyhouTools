//
//  HHView.h
//  FunnyTicket
//
//  Created by tasama on 17/7/10.
//  Copyright © 2017年 Heyhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHViewHeadrRefresh.h"

@protocol HHViewMoveTouchDelegate <NSObject>

- (void)MYTouchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

- (void)MYTouchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

- (void)MYTouchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

- (void)MYTouchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

@end

#define refreshHeight [UIScreen mainScreen].bounds.size.height * 2 / 3.0f
#define refreshHeaderHeight 64.0f

@interface HHView : UIView

@property (nonatomic, weak) id <HHViewMoveTouchDelegate> delegate;

@property (nonatomic, strong) HHViewHeadrRefresh *headRefreh;

@end
