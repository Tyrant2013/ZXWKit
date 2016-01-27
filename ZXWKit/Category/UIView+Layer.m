//
//  UIView+Layer.m
//  ZXWKit
//
//  Created by 庄晓伟 on 16/1/27.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import "UIView+Layer.h"

@implementation UIView (Layer)

- (void)zxw_cornerRadius:(CGFloat)radius borderColor:(UIColor *)color {
    self.layer.cornerRadius = radius;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 1.0f;
}

@end
