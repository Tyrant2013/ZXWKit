//
//  NSString+Extern.m
//  ZXWKit
//
//  Created by 庄晓伟 on 16/2/19.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import "NSString+Extern.h"


@implementation NSString (Extern)

- (NSString *)transformMandarinToLatin:(NSString *)string {
    NSMutableString *preString = [string mutableCopy];
    /*转换成成带音 调的拼音*/
    CFStringTransform((CFMutableStringRef)preString, NULL, kCFStringTransformMandarinLatin, NO);
    /*去掉音调*/
    CFStringTransform((CFMutableStringRef)preString, NULL, kCFStringTransformStripDiacritics, NO);
    return preString;
}

@end
