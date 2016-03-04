//
//  UIView+Animations.m
//  ZXWKit
//
//  Created by 庄晓伟 on 16/1/27.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import "UIView+Animations.h"


@implementation UIView (Animations)

- (void)zxw_beginHeartAnimation {
    UIViewAnimationOptions op = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionBeginFromCurrentState;
    [UIView animateWithDuration:0.15f delay:0 options:op animations:^{
        [self.layer setValue:@(0.80) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:op animations:^{
            [self.layer setValue:@(1.3) forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 delay:0 options:op animations:^{
                [self.layer setValue:@(1) forKeyPath:@"transform.scale"];
            } completion:NULL];
        }];
    }];
}

- (void)zxw_beginTransitionAnimation {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.75f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.layer addAnimation:transition forKey:nil];
}


@end
