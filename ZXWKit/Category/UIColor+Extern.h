//
//  UIColor+Extern.h
//  ZXWKit
//
//  Created by 庄晓伟 on 16/1/27.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extern)

+ (UIColor *)zxw_colorWithHexString:(NSString *)hexString;
+ (UIColor *)zxw_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

- (UIImage *)zxw_imageWithSize:(CGSize)size;

@end
