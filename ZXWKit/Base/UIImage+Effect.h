//
//  UIImage+Effect.h
//  ZXWKit
//
//  Created by 庄晓伟 on 16/1/27.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Effect)

- (UIImage *)zxw_applyLightEffect;
- (UIImage *)zxw_applyExtraLightEffect;
- (UIImage *)zxw_applyDarkEffect;
- (UIImage *)zxw_applyTintEffectWithColor:(UIColor *)tintColor;
- (UIImage *)zxw_applyBlurWithRadius:(CGFloat)blurRadius
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage;


- (UIImage *)zxw_boxblurImageWithBlur:(CGFloat)blur;

@end
