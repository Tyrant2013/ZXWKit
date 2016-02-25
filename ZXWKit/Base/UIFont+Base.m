//
//  UIFont+Base.m
//  ZXWKit
//
//  Created by 庄晓伟 on 16/1/28.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import "UIFont+Base.h"


@implementation UIFont (Base)

+ (UIFont *)zxw_fontFromCTFont:(CTFontRef)ctFont {
    CGFloat pointSize = CTFontGetSize(ctFont);
    NSString *fontPostScriptName = (NSString *)CFBridgingRelease(CTFontCopyPostScriptName(ctFont));
    UIFont *fontFromCTFont = [UIFont fontWithName:fontPostScriptName size:pointSize];
    return fontFromCTFont;
}

- (CTFontRef)zxw_ctFont {
    CTFontRef ctfont = CTFontCreateWithName((__bridge CFStringRef)self.fontName,
                                            self.pointSize,
                                            NULL);
    return CFAutorelease(ctfont);
}

@end
