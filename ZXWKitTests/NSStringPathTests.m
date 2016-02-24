//
//  NSStringPathTests.m
//  ZXWKit
//
//  Created by 庄晓伟 on 16/1/29.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import "NSStringPathTests.h"
#import <ZXWKit/NSString+Path.h>


@implementation NSStringPathTests

- (void)testBezierPath
{
    NSString *str = @"aaaaa";
    UIFont *font = [UIFont systemFontOfSize:20];
    UIBezierPath *bezierPath = [str bezierPathWithFont:font];
    NSAssert(bezierPath != nil, @"bezier path must not be nil");
}

@end
