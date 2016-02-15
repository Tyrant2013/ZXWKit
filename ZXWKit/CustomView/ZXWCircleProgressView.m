//
//  ZXWCircleProgressView.m
//  KKitTestDemo
//
//  Created by 庄晓伟 on 16/2/15.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import "ZXWCircleProgressView.h"

static CGFloat const kAnimationDuration                                 = 0.25f;

@interface ZXWCircleProgressView()

@property (nonatomic, strong) CAShapeLayer                              *shapeLayer;

@end

@implementation ZXWCircleProgressView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_setup];
        [self p_setupAnimation];
    }
    return self;
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
    
    _shapeLayer.lineWidth = self.strokeWidth;
    _shapeLayer.fillColor = self.backgroundColor.CGColor;
    _shapeLayer.strokeColor = self.strokeColor.CGColor;
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

- (UIColor *)backgroundColor {
    if (_backgroundColor == nil) {
        _backgroundColor = [UIColor whiteColor];
    }
    return _backgroundColor;
}

- (UIColor *)strokeColor {
    if (_strokeColor == nil) {
        _strokeColor = [UIColor orangeColor];
    }
    return _strokeColor;
}

- (CGFloat)strokeWidth {
    if (_strokeWidth == 0.0f) {
        _strokeWidth = 1.0f;
    }
    return _strokeWidth;
}

@end
