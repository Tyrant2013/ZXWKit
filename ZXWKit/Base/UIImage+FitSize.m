//
//  UIImage+FitSize.m
//  AutoLearning
//
//  Created by 庄晓伟 on 16/2/16.
//  Copyright © 2016年 Zhuhai Auto-Learning Co.,Ltd. All rights reserved.
//

#import "UIImage+FitSize.h"


@implementation UIImage (FitSize)

- (UIImage *)zxw_fitSize:(CGSize)size {
    if (self.size.width != size.width || self.size.height != size.height) {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
        CGRect imageRect = (CGRect){0, 0, size};
        [self drawInRect:imageRect];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
    return self;
}

@end
