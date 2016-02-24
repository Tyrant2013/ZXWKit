//
//  NSString+Path.m
//  ZXWKit
//
//  Created by 庄晓伟 on 16/1/28.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import "NSString+Path.h"
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>


@implementation NSString (Path)

- (UIBezierPath *)bezierPathWithFont:(UIFont *)font
{
    CGMutablePathRef letters = CGPathCreateMutable();

    CTFontRef ctFont = CTFontCreateWithName((__bridge CFStringRef)font.fontName,
                                            font.pointSize,
                                            NULL);
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                            (__bridge id)ctFont, kCTFontAttributeName,
                                            nil];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"Great pain shapes Legend"
                                                                     attributes:attrs];
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attrString);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);

    // for each RUN
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++) {
        // Get FONT for this run
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);

        // for each GLYPH in run
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++) {
            // get Glyph & Glyph-data
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);

            // Get PATH of outline
            {
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
            }
        }
    }
    CFRelease(line);

    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithCGPath:letters];
    CGPathRelease(letters);
    CFRelease(ctFont);
    return bezierPath;
}

@end
