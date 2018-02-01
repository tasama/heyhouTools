//
//  ProgressView.m
//  progressTest
//
//  Created by tasama on 16/10/14.
//  Copyright © 2016年 tasama. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView ()

@end

@implementation ProgressView

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    if (self.type == ProgressViewCircleType) {
        CGContextRef ctx = UIGraphicsGetCurrentContext();//获取上下文
        
        CGPoint center = CGPointMake(100, 100);  //设置圆心位置
        CGFloat radius = 90;  //设置半径
        CGFloat startA = - M_PI_2;  //圆起点位置
        CGFloat endA = -M_PI_2 + M_PI * 2 * _progress;  //圆终点位置
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
        
        CGContextSetLineWidth(ctx, 10); //设置线条宽度
        [self.fillColor setStroke]; //设置描边颜色
        
        CGContextAddPath(ctx, path.CGPath); //把路径添加到上下文
        
        CGContextStrokePath(ctx);  //渲染
    } else if (self.type == ProgressViewLineType) {

        CGContextRef ctx = UIGraphicsGetCurrentContext();//获取上下文
        
        CGFloat width = self.progress * rect.size.width; //设置进度条长度
        CGFloat height = rect.size.height; //进度条宽度
        
        UIColor *fillColor = self.fillColor; //设置填充颜色
        [fillColor setFill];
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0,0, width, height)];
        
        CGContextAddPath(ctx, path.CGPath);
        
        CGContextFillPath(ctx);
    }
}

- (void)setProgress:(CGFloat)progress {
    
    _progress = progress;
    [self setNeedsDisplay];
    
}

@end
