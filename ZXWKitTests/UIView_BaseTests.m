//
//  UIView_Base.m
//  ZXWKit
//
//  Created by 庄晓伟 on 16/1/27.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import "UIView_BaseTests.h"
#import "UIView+Base.h"

@implementation UIView_BaseTest

- (void)setUp {
    
}

- (void)tearDown {
    
}

- (void)testX {
    UIView *view = [[UIView alloc] initWithFrame:(CGRect){10, 0, 0, 0}];
    NSAssert(view.x == 10, @"must equal to 10");
    view = [[UIView alloc] init];
    NSAssert(view.x == 0, @"must equal to 0");
}

@end
