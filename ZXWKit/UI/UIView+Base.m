//
//  UIView+Base.m
//  ZXWKit
//
//  Created by 庄晓伟 on 16/1/25.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import "UIView+Base.h"


@implementation UIView (Base)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return CGRectGetMinX(self.frame);
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return CGRectGetMinY(self.frame);
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return CGRectGetHeight(self.frame);
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return CGRectGetWidth(self.frame);
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    CGFloat height = bottom - CGRectGetMinY(frame);
    if (height >= 0.f) {
        frame.size.height = height;
        self.frame = frame;
    }
}

- (CGFloat)bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setTop:(CGFloat)top
{
    self.y = top;
}

- (CGFloat)top
{
    return self.y;
}

- (void)setLeft:(CGFloat)left
{
    self.x = left;
}

- (CGFloat)left
{
    return self.x;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    CGFloat width = right - frame.origin.x;
    if (width >= 0.f) {
        frame.size.width = width;
        self.frame = frame;
    }
}

- (CGFloat)right
{
    return CGRectGetMaxX(self.frame);
}

@end
