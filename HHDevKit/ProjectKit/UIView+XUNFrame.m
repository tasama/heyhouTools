//
//  \\      //     ||          ||     ||\        ||
//   \\    //      ||          ||     ||\\       ||
//    \\  //       ||          ||     || \\      ||
//     \\//        ||          ||     ||  \\     ||
//      /\         ||          ||     ||   \\    ||
//     //\\        ||          ||     ||    \\   ||
//    //  \\       ||          ||     ||     \\  ||
//   //    \\      ||          ||     ||      \\ ||
//  //      \\      \\        //      ||       \\||
// //        \\      \\======//       ||        \||
//
//
//  UIView+XUNFrame.m
//  ProjectKit
//
//  Created by xun on 16/12/12.
//  Copyright © 2016年 Xun. All rights reserved.
//

#import "UIView+XUNFrame.h"

@implementation UIView (XUNFrame)

- (CGFloat)x
{
    return self.frame.origin.x;
}

-(void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y{
    
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

-(void)setWidth:(CGFloat)width{
    
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

-(void)setHeight:(CGFloat)height{
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

-(void)setSize:(CGSize)size{
    
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

-(void)setOrigin:(CGPoint)origin{
    
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

-(void)setCenterX:(CGFloat)centerX{
    
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

-(void)setCenterY:(CGFloat)centerY{
    
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)maxX
{
    return self.x + self.width;
}

-(void)setMaxX:(CGFloat)maxX{
    
    self.x += maxX;
}

- (CGFloat)maxY
{
    return self.y + self.height;
}

-(void)setMaxY:(CGFloat)maxY{
    
    self.y += maxY;
}

#pragma mark - 适配

- (void)fill {
    
    NSAssert(self.superview, @"请将视图添加至父视图");
    
    self.frame = self.superview.bounds;
}

- (void)fillWidth {
    
    NSAssert(self.superview, @"请将视图添加至父视图");
    
    self.width = self.superview.width;
    self.x = 0;
}

- (void)fillHeight {
    
    NSAssert(self.superview, @"请将视图添加至父视图");
    
    self.height = self.superview.height;
    self.y = 0;
}

@end
