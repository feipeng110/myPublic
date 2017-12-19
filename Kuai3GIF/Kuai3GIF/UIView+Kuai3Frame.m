//
//  UIView+Kuai3Frame.m
//  Kuai3GIF
//
//  Created by feipeng on 2017/12/14.
//  Copyright © 2017年 feipeng. All rights reserved.
//

#import "UIView+Kuai3Frame.h"

@implementation UIView (Kuai3Frame)
- (CGFloat)k3_top
{
    return self.frame.origin.y;
}

- (void)setK3_top:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)k3_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setK3_right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)k3_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setK3_bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)k3_left
{
    return self.frame.origin.x;
}

- (void)setK3_left:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)k3_width
{
    return self.frame.size.width;
}

- (void)setK3_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)k3_height
{
    return self.frame.size.height;
}

- (void)setK3_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

#pragma mark - Shortcuts for frame properties

- (CGPoint)k3_origin {
    return self.frame.origin;
}

- (void)setK3_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)k3_size {
    return self.frame.size;
}

- (void)setK3_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
#pragma mark - Shortcuts for positions

- (CGFloat)k3_centerX {
    return self.center.x;
}

- (void)setK3_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)k3_centerY {
    return self.center.y;
}

- (void)setK3_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}
@end
