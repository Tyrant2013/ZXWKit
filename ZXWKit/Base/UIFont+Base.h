//
//  UIFont+Base.h
//  ZXWKit
//
//  Created by 庄晓伟 on 16/1/28.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface UIFont (Base)

+ (UIFont *)zxw_fontFromCTFont:(CTFontRef)ctFont;
- (CTFontRef)zxw_ctFont;

@end
