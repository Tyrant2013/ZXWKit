//
//  NSArray+Extern.m
//  ZXWKit
//
//  Created by 庄晓伟 on 16/2/25.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import "NSArray+Extern.h"

@implementation NSArray (Extern)

- (NSArray *)zxw_distinct {
    return [self valueForKeyPath:@"distinctUnionOfObjects.self"];
}

@end
