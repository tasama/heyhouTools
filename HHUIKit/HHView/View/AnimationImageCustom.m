//
//  AnimationImageCustom.m
//  UIViewWaterAnimation
//
//  Created by tasama on 17/7/20.
//  Copyright © 2017年 tasama. All rights reserved.
//

#import "AnimationImageCustom.h"

#define SYS_DEVICE_WIDTH    ([[UIScreen mainScreen] bounds].size.width)                  // 屏幕宽度
#define SYS_DEVICE_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)                 // 屏幕长度
#define MIN_HEIGHT          100  

@interface AnimationImageCustom ()

@property (nonatomic, strong) CAShapeLayer *waveShapeLayer;

@property (nonatomic, strong) CAShapeLayer *waveShapeLayerT;

@property (nonatomic, assign) CGFloat offsetX;

@property (nonatomic, strong) CADisplayLink *waveDisplayLink;

@end

@implementation AnimationImageCustom



- (void)wave {
    
    self.hidden = NO;
    /*
     
     *创建两个layer
     
     */
    
    self.waveShapeLayer = [CAShapeLayer layer];
    
    self.waveShapeLayer.fillColor = [UIColor whiteColor].CGColor;
    
    [self.layer addSublayer:self.waveShapeLayer];
    
    self.waveShapeLayerT = [CAShapeLayer layer];
    
    self.waveShapeLayerT.fillColor = [UIColor whiteColor].CGColor;
    
    [self.layer addSublayer:self.waveShapeLayerT];
    
    /*
     
     *CADisplayLink是一个能让我们以和屏幕刷新率相同的频率将内容画到屏幕上的定时器。我们在应用中创建一个新的 CADisplayLink 对象，把它添加到一个runloop中，并给它提供一个 target 和selector 在屏幕刷新的时候调用。
     
     */
    
    self.waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave)];
    
    [self.waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)stop {
    
    self.hidden = YES;
    [self.waveDisplayLink isPaused];
    [self.waveDisplayLink invalidate];
    self.waveDisplayLink = nil;
}

//CADispayLink相当于一个定时器 会一直绘制曲线波纹 看似在运动，其实是一直在绘画不同位置点的余弦函数曲线
- (void)getCurrentWave {
    
    //offsetX决定x位置，如果想搞明白可以多试几次
    
    self.offsetX += self.waveSpeed;
    
    //声明第一条波曲线的路径
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    //设置起始点
    
    CGPathMoveToPoint(path, nil, 0, self.waveHeight);
    
    CGFloat y = 0.f;
    
    //第一个波纹的公式
    
    for (float x = 0.f; x <= self.waveWidth ; x++) {
        
        y = self.waveAmplitude * sin((300 / self.waveWidth) * (x * M_PI / 180) - self.offsetX * M_PI / 270) + self.waveHeight* 1;
        
        CGPathAddLineToPoint(path, nil, x, y);
        
        x++;
        
    }
    
    //把绘图信息添加到路径里
    
    CGPathAddLineToPoint(path, nil, self.waveWidth, self.frame.size.height);
    
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    
    //结束绘图信息
    
    CGPathCloseSubpath(path);
    
    self.waveShapeLayer.path = path;
    
    //释放绘图路径
    
    CGPathRelease(path);
    
    /*
     
     *  第二个
     
     */
    
    self.offsetXT += self.waveSpeed;
    
    CGMutablePathRef pathT = CGPathCreateMutable();
    
    CGPathMoveToPoint(pathT, nil, 0, self.waveHeight+100);
    
    CGFloat yT = 0.f;
    
    for (float x = 0.f; x <= self.waveWidth ; x++) {
        
        yT = self.waveAmplitude*1.6 * sin((260 / self.waveWidth) * (x * M_PI / 180) - self.offsetXT * M_PI / 180) + self.waveHeight;
        
        CGPathAddLineToPoint(pathT, nil, x, yT-10);
        
    }
    
    CGPathAddLineToPoint(pathT, nil, self.waveWidth, self.frame.size.height);
    
    CGPathAddLineToPoint(pathT, nil, 0, self.frame.size.height);
    
    CGPathCloseSubpath(pathT);
    
    self.waveShapeLayerT.path = pathT;
    
    CGPathRelease(pathT);
    
}


@end
