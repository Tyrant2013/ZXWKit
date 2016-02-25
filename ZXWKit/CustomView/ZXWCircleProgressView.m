//
//  ZXWCircleProgressView.m
//  KKitTestDemo
//
//  Created by 庄晓伟 on 16/2/15.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import "ZXWCircleProgressView.h"

static CGFloat const kAnimationDuration = 0.25f;


@interface ZXWCircleProgressView ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end


@implementation ZXWCircleProgressView

@synthesize circleStrokeColor = _circleStrokeColor,
            circleBackgroundColor = _circleBackgroundColor,
            circleStrokeWidth = _circleStrokeWidth;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //        [self p_setup];
        //        [self p_setupAnimation];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [self p_setup];
    [self p_setupAnimation];
}

- (void)layoutSubviews {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [super layoutSubviews];
    self.shapeLayer.strokeColor = self.circleStrokeColor.CGColor;
    self.shapeLayer.fillColor = self.circleBackgroundColor.CGColor;
    self.shapeLayer.lineWidth = self.circleStrokeWidth;
    self.shapeLayer.timeOffset = self.progress * kAnimationDuration;
}

- (void)p_setup {
    if (_shapeLayer != nil) {
        return;
    }
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.bounds = self.bounds;
    _shapeLayer.position = (CGPoint){CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2};
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    _shapeLayer.path = bezierPath.CGPath;

    [self.layer addSublayer:_shapeLayer];
}

- (void)p_setupAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = kAnimationDuration;
    animation.fromValue = @0.0f;
    animation.toValue = @1.0f;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [_shapeLayer addAnimation:animation forKey:@"strokeEndAnimation"];
    _shapeLayer.speed = 0.0f;
}

- (void)setProgress:(CGFloat)progress {
    CGFloat value = MIN(MAX(0.0, progress), 1);
    self.shapeLayer.timeOffset = kAnimationDuration * value;
}

- (UIColor *)circleBackgroundColor {
    if (_circleBackgroundColor == nil) {
        _circleBackgroundColor = [UIColor whiteColor];
    }
    return _circleBackgroundColor;
}

- (void)setCircleBackgroundColor:(UIColor *)circleBackgroundColor {
    _circleBackgroundColor = circleBackgroundColor;
    self.shapeLayer.fillColor = circleBackgroundColor.CGColor;
}

- (UIColor *)circleStrokeColor {
    if (_circleStrokeColor == nil) {
        _circleStrokeColor = [UIColor orangeColor];
    }
    return _circleStrokeColor;
}

- (void)setCircleStrokeColor:(UIColor *)circleStrokeColor {
    _circleStrokeColor = circleStrokeColor;
    self.shapeLayer.strokeColor = circleStrokeColor.CGColor;
}

- (CGFloat)circleStrokeWidth {
    if (_circleStrokeWidth == 0.0f) {
        _circleStrokeWidth = 1.0f;
    }
    return _circleStrokeWidth;
}

- (void)setCircleStrokeWidth:(CGFloat)circleStrokeWidth {
    _circleStrokeWidth = circleStrokeWidth;
    self.shapeLayer.lineWidth = circleStrokeWidth;
}

@end
