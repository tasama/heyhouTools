//
//  AnimationImageCustom.h
//  UIViewWaterAnimation
//
//  Created by tasama on 17/7/20.
//  Copyright © 2017年 tasama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationImageCustom : UIView

@property (nonatomic, assign) CGFloat waveHeight;

@property (nonatomic, assign) CGFloat waveWidth;

@property (nonatomic, assign) CGFloat waveAmplitude;

@property (nonatomic, assign) CGFloat offsetXT;

@property (nonatomic, assign) CGFloat waveSpeed;

- (void)wave;

- (void)stop;


@end
