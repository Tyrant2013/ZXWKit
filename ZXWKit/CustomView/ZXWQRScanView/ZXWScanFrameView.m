//
//  ZXWScanFramView.m
//  ZXWKit
//
//  Created by 庄晓伟 on 16/3/3.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import "ZXWScanFrameView.h"

static CGFloat const                        kMarginHorizotal                    = 80.0f;
static CGFloat const                        kCornerLineLength                   = 15.0f;
static CGFloat const                        kCornerLineWidth                    = 3.0f;
static NSTimeInterval                       kAnimationDuration                  = 3.0f;
static CGFloat const                        kMoveLinePadding                    = 10.0f;
static CGFloat const                        kMoveLineheight                     = 3.0f;

@implementation ZXWScanFrameView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame scanFram:(CGRect)scanFrame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.scanFrame = scanFrame;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGRect scanRect = self.scanFrame;
    if (CGRectIsEmpty(scanRect)) {
        CGFloat width = CGRectGetWidth(rect) - 2 * kMarginHorizotal;
        CGFloat height = width;
        CGFloat posX = (CGRectGetWidth(rect) - width) / 2;
        CGFloat posY = (CGRectGetHeight(rect) - height) / 2;
        scanRect = (CGRect){posX, posY, width, height};
        self.scanFrame = scanRect;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    [[[UIColor blackColor] colorWithAlphaComponent:0.2f] setFill];
    
    CGMutablePathRef screenPath = CGPathCreateMutable();
    CGPathAddRect(screenPath, NULL, rect);
    
    CGMutablePathRef scanPath = CGPathCreateMutable();
    CGPathAddRect(scanPath, NULL, scanRect);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddPath(path, NULL, screenPath);
    CGPathAddPath(path, NULL, scanPath);
    
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathEOFill);
    
    CGPathRelease(screenPath);
    CGPathRelease(scanPath);
    CGPathRelease(path);
    CGContextRestoreGState(context);
    
    [self addCornerWithContext:context scanFame:scanRect];
    [self addMovableLine:context inScanFrame:scanRect];
}

- (void)addCornerWithContext:(CGContextRef)context scanFame:(CGRect)scanRect {
    CGFloat minX = CGRectGetMinX(scanRect);
    CGFloat minY = CGRectGetMinY(scanRect);
    CGFloat maxX = CGRectGetMaxX(scanRect);
    CGFloat maxY = CGRectGetMaxY(scanRect);
    
    CGPoint startPoint = (CGPoint){minX, minY + kCornerLineLength};
    CGPoint cornerPoint = scanRect.origin;
    CGPoint endPoint = (CGPoint){minX + kCornerLineLength, minY};
    [self addLineFrom:startPoint cornerPoint:cornerPoint endPoint:endPoint context:context];
    
    startPoint = (CGPoint){maxX - kCornerLineLength, minY};
    cornerPoint = (CGPoint){maxX, minY};
    endPoint = (CGPoint){maxX, minY + kCornerLineLength};
    [self addLineFrom:startPoint cornerPoint:cornerPoint endPoint:endPoint context:context];
    
    startPoint = (CGPoint){maxX, maxY - kCornerLineLength};
    cornerPoint = (CGPoint){maxX, maxY};
    endPoint = (CGPoint){maxX - kCornerLineLength, maxY};
    [self addLineFrom:startPoint cornerPoint:cornerPoint endPoint:endPoint context:context];
    
    startPoint = (CGPoint){minX + kCornerLineLength, maxY};
    cornerPoint = (CGPoint){minX, maxY};
    endPoint = (CGPoint){minX, maxY - kCornerLineLength};
    [self addLineFrom:startPoint cornerPoint:cornerPoint endPoint:endPoint context:context];
}

- (void)addLineFrom:(CGPoint)startPoint cornerPoint:(CGPoint)cornerPoint endPoint:(CGPoint)endPoint context:(CGContextRef)context {
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, kCornerLineWidth);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, cornerPoint.x, cornerPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

- (void)addMovableLine:(CGContextRef)context inScanFrame:(CGRect)scanFrame {
    
    CGRect frame = (CGRect){0, 0, CGRectGetWidth(scanFrame) - kMoveLinePadding, kMoveLineheight};
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:frame];
    CAShapeLayer *line = [CAShapeLayer layer];
    line.path = path.CGPath;
    line.fillColor = [UIColor greenColor].CGColor;
    line.anchorPoint = (CGPoint){0.0, 0.0};
    [self.layer addSublayer:line];
    line.position = (CGPoint){self.center.x - CGRectGetWidth(frame) / 2, self.center.y};
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.fromValue = @(CGRectGetMinY(scanFrame));
    animation.toValue = @(CGRectGetMaxY(scanFrame));
    animation.removedOnCompletion = NO;
    animation.repeatDuration = CGFLOAT_MAX;
    animation.duration = kAnimationDuration;
    [line addAnimation:animation forKey:@"move"];
}

- (void)drawLinearGradient:(CGContextRef)context path:(CGPathRef)path startColor:(UIColor *)startColor endColor:(UIColor *)endColor {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    NSArray *colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

- (void)startAnimation {
    self.layer.speed = 1.0f;
}

- (void)stopAnimation {
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0f;
    self.layer.timeOffset = pausedTime;
}

@end
